use std::io::{BufRead, BufReader};
use std::fs::File;
use std::collections::HashMap;

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let input_lines: Vec<_> = input_file.lines().map(|line| { line.unwrap() }).collect();
    assert!(input_lines.len() > 0, "empty input");
    let mut register = HashMap::new();

    let mut mul_counter = 0;
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
            "set" => {
                *register_entry = value;
                println!("{}: set {} to {}", line_number, register_name, value);
                line_number += 1;
            }
            "sub" => {
                *register_entry -= value;
                println!("{}: add {} to {}", line_number, value, register_name);
                line_number += 1;
            }
            "mul" => {
                *register_entry *= value;
                mul_counter+= 1;
                println!("{}: multiply {} by {}", line_number, register_name, value);
                line_number += 1;
            }
            "jnz" => {
                if comparer != 0 {
                    println!("{}: jump by {}", line_number, value);
                    line_number += value as i32;
                } else {
                    line_number += 1;
                }
            }
            _ => {}
        }
    }
    println!("mul counter: {}",mul_counter);
}