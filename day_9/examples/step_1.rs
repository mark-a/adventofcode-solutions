use std::io::{BufRead, BufReader};
use std::fs::File;

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let input_lines: Vec<_> = input_file.lines().map(|line| { line.unwrap() }).collect();
    assert!(input_lines.len() > 0, "empty input");
    let mut chars: Vec<char> = input_lines[0].chars().collect();


    let mut total_value = 0;
    let mut local_value = 0;
    let mut garbage_mode = false;
    let mut ignore_mode = false;
    let mut garbage_counter = 0;

    for character in chars {
        if !ignore_mode {
            match character {
                '!' => {
                    ignore_mode = true;
                },
                '<' => {
                    if !garbage_mode{
                        garbage_mode = true;
                    }else{
                        garbage_counter+=1;
                    }
                },
                '>' => {
                    garbage_mode = false;
                },
                '{' => {
                    if !garbage_mode{
                        local_value += 1;
                    }else{
                        garbage_counter+=1;
                    }
                },
                '}' => {
                    if !garbage_mode{
                        total_value += local_value;
                        local_value -= 1;
                    }else{
                        garbage_counter+=1;
                    }
                },
                _ => {
                    if garbage_mode {
                        garbage_counter+=1;
                    }

                },
            }
        } else {
            ignore_mode = false;
        }
    }

    println!("total: {}",total_value);

    println!("garbage: {}",garbage_counter);
}
