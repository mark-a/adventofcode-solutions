use std::io::{BufRead, BufReader};
use std::fs::File;
use std::collections::HashMap;

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let mut scanners = HashMap::new();
    let mut highest = 0;
    for io_line in input_file.lines() {
        let line = io_line.unwrap();
        let parts: Vec<_> = line.split(": ").collect();
        let depth: i32 = parts[1].parse::<i32>().ok().unwrap();
        let position: i32 = parts[0].parse::<i32>().ok().unwrap();
        highest = position;
        scanners.insert( position, depth);
    }

    let mut severity = 0;
    for step in 0..highest+1 {
        match scanners.get(&step) {
            Some(scanner_depth) => {
                // one circular motion takes n + n - 2 steps
                if step % (scanner_depth + scanner_depth - 2) == 0{
                    severity += step* scanner_depth;
                }
            },
            None => {}
        };
    }

    println!("accumulated severity {}", severity);
}
