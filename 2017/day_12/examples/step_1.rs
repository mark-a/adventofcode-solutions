use std::io::{BufRead, BufReader};
use std::fs::File;
use std::collections::HashMap;

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let mut pipes = HashMap::new();
    for io_line in input_file.lines() {
        let line = io_line.unwrap();
        let parts: Vec<_> = line.split(" <-> ").collect();
        let targets: Vec<String> = parts[1].split(", ").map(|s| String::from(s)).collect();
        pipes.insert(String::from(parts[0]), targets);
    }

    let mut counter = 0;
    let mut work_queue = vec![String::from("0")];
    let mut seen = HashMap::new();

    while work_queue.len() > 0 {
        let current = work_queue.pop().unwrap();
        println!("got {}", current);
        let seen_count = seen.entry(current.clone()).or_insert(0);
        *seen_count += 1;
        if *seen_count <= 1 {
            counter += 1;
            let neighbors = pipes.get(&current).unwrap();
            for neighbor in neighbors {
                work_queue.push(neighbor.clone());
            }
        }
    }

    println!("connected to 0: {:?}", counter);
}
