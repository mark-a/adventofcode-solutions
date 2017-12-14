use std::collections::HashMap;
use std::io::{BufRead, BufReader};
use std::fs::File;

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let mut input_lines: Vec<_> = input_file.lines().map(|line| { line.unwrap() }).collect();
    assert!(input_lines.len() > 0, "empty input");

    let mut valid_counter = 0;

    for (i,line) in input_lines.iter().enumerate() {
        let mut map = HashMap::new();
        let words: Vec<&str> = line.split_whitespace().collect();
        for word in words {
            let counter = map.entry(word).or_insert(0);
            *counter += 1;
        }
        let invalid_map: HashMap<_,_> = map.iter().filter(|&(_, v)| *v > 1)
            .collect();
        if invalid_map.is_empty() {
            valid_counter += 1;
            println!("line {} is valid",i +1);
        }
    }

    println!("{}",valid_counter);
}
