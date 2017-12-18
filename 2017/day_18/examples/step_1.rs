use std::io::{BufRead, BufReader};
use std::fs::File;
use std::collections::HashMap;

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let input_lines: Vec<_> = input_file.lines().map(|line| { line.unwrap() }).collect();
    assert!(input_lines.len() > 0, "empty input");
    let mut register = HashMap::new();

    let mut last_played = 0;
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
                last_played = *register_entry;
                println!("{}: played sound: {}", line_number, last_played);
                line_number += 1;
            }
            "set" => {
                *register_entry = partner;
                println!("{}: set {} to {}", line_number, register_name, partner);
                line_number += 1;
            }
            "add" => {
                *register_entry += partner;
                println!("{}: add {} to {}", line_number, partner, register_name);
                line_number += 1;
            }
            "mul" => {
                *register_entry *= partner;
                println!("{}: multiply {} by {}", line_number, register_name, partner);
                line_number += 1;
            }
            "mod" => {
                if partner > 0 {
                    *register_entry = *register_entry % partner;
                    println!("{}: set {} to itself modulo {}", line_number, register_name, partner);
                }
                line_number += 1;
            }
            "rcv" => {
                if *register_entry > 0 && last_played > 0 {
                    println!("{}: recovered sound: {}", line_number, last_played);
                    break;
                }
                line_number += 1;
            }
            "jgz" => {
                if *register_entry > 0 {
                    line_number += partner as i32;
                    println!("{}: jumped to: {} because register value is {}", line_number, line_number, *register_entry);
                } else {
                    line_number += 1;
                }
            }
            _ => {}
        }
    }
}