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

    let keys = pipes.keys().map(|s|s.clone()).collect();
    let mut group_counter = 0;
    let mut work_queue = Vec::new();
    let mut seen = HashMap::new();

    while seen.keys().len() < pipes.keys().len() {

        if let Some(next) = get_next_unseen(&keys, &seen) {
            work_queue.push(next);
            group_counter += 1;
        }
        while work_queue.len() > 0 {
            let current = work_queue.pop().unwrap();
            let seen_count = seen.entry(current.clone()).or_insert(0);
            *seen_count += 1;
            if *seen_count <= 1 {
                let neighbors = pipes.get(&current).unwrap();
                for neighbor in neighbors {
                    work_queue.push(neighbor.clone());
                }
            }
        }
    }
    println!("found {} groups", group_counter);
}

fn get_next_unseen(possible: &Vec<String>, filter: &HashMap<String, i32>) -> Option<String> {
    for item in possible {
        if !filter.contains_key(item) {
            return Some(item.clone());
        }
    }
    return None;
}
