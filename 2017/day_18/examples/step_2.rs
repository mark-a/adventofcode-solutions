use std::io::{BufRead, BufReader};
use std::fs::File;
use std::collections::HashMap;
use std::thread;
use std::sync::mpsc::{channel, Sender, Receiver};
use std::time::Duration;

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let input_lines: Vec<_> = input_file.lines().map(|line| { line.unwrap() }).collect();
    assert!(input_lines.len() > 0, "empty input");

    let (p0_tx, p0_rx) = channel::<i64>();
    let (p1_tx, p1_rx) = channel::<i64>();

    let input_clone = input_lines.clone();

    thread::spawn(move || {
        let mut program0 = Program {
            program_id: 0,
            sender: p0_tx,
            receiver: p1_rx,
            send_counter: 0,
        };

        program0.run(input_clone);
    });

    let mut program1 = Program {
        program_id: 1,
        sender: p1_tx,
        receiver: p0_rx,
        send_counter: 0,
    };

    program1.run(input_lines);
    println!("Program 1 terminates with send count {}", program1.send_counter);
}

struct Program {
    program_id: i64,
    sender: Sender<i64>,
    receiver: Receiver<i64>,
    send_counter: i64,
}

impl Program {
    fn run(&mut self, input_lines: Vec<String>) {
        let mut register = HashMap::new();
        register.insert('p', self.program_id);
        let mut line_number: i32 = 0;
        while line_number < input_lines.len() as i32 {
            let line = &input_lines[line_number as usize];
            let instruct_parts: Vec<_> = line.split_whitespace().collect();
            let register_name = instruct_parts[1].chars().nth(0).unwrap();

            let mut value: i64 = 0;
            if instruct_parts.len() > 2 {
                value = match instruct_parts[2].parse::<i64>() {
                    Ok(n) => n,
                    Err(_) => {
                        let value_register_name = instruct_parts[2].chars().nth(0).unwrap();
                        *(&mut register).get(&value_register_name).unwrap_or(&0)
                    }
                };
            }

            let register_entry = register.entry(register_name).or_insert(0 as i64);

            let comparer;
            if !register_name.is_digit(10) {
                comparer = *register_entry;
            } else {
                comparer = instruct_parts[1].parse::<i64>().unwrap();
            }

            match instruct_parts[0] {
                "snd" => {
                    self.sender.send(comparer).expect("Could not send to channel");
                    self.send_counter += 1;
                    line_number += 1;
                }
                "set" => {
                    *register_entry = value;
                    line_number += 1;
                }
                "add" => {
                    *register_entry += value;
                    line_number += 1;
                }
                "mul" => {
                    *register_entry *= value;
                    line_number += 1;
                }
                "mod" => {
                    if value > 0 {
                        *register_entry = *register_entry % value;
                    }
                    line_number += 1;
                }
                "rcv" => {
                    // used a timeout of 100 milliseconds as criteria for a deadlock
                    if let Ok(received_value) = self.receiver.recv_timeout(Duration::from_millis(100)) {
                        *register_entry = received_value;
                        line_number += 1;
                    } else {
                        break;
                    }
                }
                "jgz" => {
                    if comparer > 0 {
                        line_number += value as i32;
                    } else {
                        line_number += 1;
                    }
                }
                _ => {}
            }
        }
    }
}