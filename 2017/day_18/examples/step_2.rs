use std::io::{BufRead, BufReader};
use std::fs::File;
use std::collections::HashMap;
use std::thread;
use std::sync::mpsc::{channel,Sender,Receiver};

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let input_lines: Vec<_> = input_file.lines().map(|line| { line.unwrap() }).collect();
    assert!(input_lines.len() > 0, "empty input");

    let (p0_tx, p0_rx) = channel::<i64>();
    let (p1_tx, p1_rx) = channel::<i64>();

    let input_clone = input_lines.clone();

    thread::spawn(move|| {
        let mut program0 = Program {
            program_id: 0,
            sender:  p1_tx,
            receiver:  p0_rx,
            send_counter: 0,
        };

        program0.run(input_clone);
    });

    let mut program1 = Program {
        program_id: 1,
        sender: p0_tx,
        receiver: p1_rx,
        send_counter: 0,
    };

    program1.run(input_lines);
    println!("{}",program1.send_counter);
}

struct Program {
    program_id: i64,
    sender:  Sender<i64>,
    receiver: Receiver<i64>,
    send_counter : i64,
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
            let register2 = &register.clone();
            let register_entry = register.entry(register_name).or_insert(0 as i64);
            let mut partner: i64 = 0;
            if instruct_parts.len() > 2 {
                partner = match instruct_parts[2].parse::<i64>() {
                    Ok(n) => n,
                    Err(_) => {
                        let partner_register_name = instruct_parts[2].chars().nth(0).unwrap();
                        *register2.get(&partner_register_name).unwrap_or(&0)
                    }
                };
            }

            match instruct_parts[0] {
                "snd" => {
                    self.sender.send(*register_entry);
                    self.send_counter += 1;
                    println!("{}::{}: send value : {}",self.program_id, line_number, *register_entry);
                    line_number += 1;
                }
                "set" => {
                    *register_entry = partner;
                    println!("{}::{}: set {} to {}",self.program_id, line_number, register_name, partner);
                    line_number += 1;
                }
                "add" => {
                    *register_entry += partner;
                    println!("{}::{}: add {} to {}",self.program_id, line_number, partner, register_name);
                    line_number += 1;
                }
                "mul" => {
                    *register_entry *= partner;
                    println!("{}::{}: multiply {} by {}",self.program_id, line_number, register_name, partner);
                    line_number += 1;
                }
                "mod" => {
                    if partner > 0 {
                        *register_entry = *register_entry % partner;
                        println!("{}::{}: set {} to itself modulo {}",self.program_id, line_number, register_name, partner);
                    }
                    line_number += 1;
                }
                "rcv" => {
                    let received_value = self.receiver.recv().unwrap();
                    *register_entry = received_value;
                    println!("{}::{}: received value: {}",self.program_id, line_number, received_value);
                    line_number += 1;
                }
                "jgz" => {
                    if *register_entry > 0 {
                        line_number += partner as i32;
                        println!("{}::{}: jumped to: {} because register value is {}",self.program_id, line_number, line_number, *register_entry);
                    } else {
                        line_number += 1;
                    }
                }
                _ => {}
            }
        }
    }
}