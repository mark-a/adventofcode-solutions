use std::io::{BufRead, BufReader};
use std::fs::File;
use std::collections::HashMap;

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let input_lines: Vec<_> = input_file.lines().map(|line| { line.unwrap() }).collect();
    assert!(input_lines.len() > 0, "empty input");
    let moves: Vec<String> = input_lines[0].split(",").map(|s| String::from(s)).collect();

    let mut working_string = String::from("abcdefghijklmnop");

    let mut end_positions = HashMap::new();
    let mut end_positions_count = HashMap::new();

    let mut loop_at = 0;
    for i in 0..1000 {
        for movement in &moves {
            match movement.chars().nth(0).unwrap() {
                's' => {
                    let move_pos = movement[1..].parse::<usize>().ok().unwrap();
                    let target = working_string.len() - move_pos;

                    working_string = format!("{}{}", &working_string[target..], &working_string[..target]);
                }
                'p' => {
                    let index_1 = working_string.find(movement.chars().nth(1).unwrap()).unwrap();
                    let index_2 = working_string.find(movement.chars().nth(3).unwrap()).unwrap();

                    let mut bytes: Vec<_> = working_string.as_bytes().to_owned();
                    bytes.swap(index_1, index_2);
                    working_string = String::from_utf8(bytes).expect("Invalid UTF-8");
                }
                'x' => {
                    let partners: Vec<_> = movement[1..].split("/").collect();
                    let index_1 = partners[0].parse::<usize>().ok().unwrap();
                    let index_2 = partners[1].parse::<usize>().ok().unwrap();

                    let mut bytes: Vec<_> = working_string.as_bytes().to_owned();
                    bytes.swap(index_1, index_2);
                    working_string = String::from_utf8(bytes).expect("Invalid UTF-8");
                }
                _ => {}
            }
        }

        end_positions.insert(i, working_string.clone());
        let seen_count = end_positions_count.entry(working_string.clone()).or_insert(0);
        *seen_count += 1;
        if *seen_count > 1 {
            loop_at = i;
            println!("loop at iteration: {}", i);
            break;
        }
        if i == 0 {
            println!("after first iteration: {}", working_string);
        }
    }

    let looped_position = (1000000000 % loop_at) - 1;
    let end_position = end_positions.get(&looped_position).unwrap();

    println!("estimated position after 1000000000 dances: {}", end_position);
}