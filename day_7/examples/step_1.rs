use std::io::{BufRead, BufReader};
use std::fs::File;
use std::collections::HashMap;

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let input_lines: Vec<_> = input_file.lines().map(|line| { line.unwrap() }).collect();
    assert!(input_lines.len() > 0, "empty input");

    let mut map = HashMap::new();

    for line in input_lines {
        let parts: Vec<_> = line.split(" -> ").collect();

        let name_and_weight :Vec<_> = parts[0].split_whitespace().collect();
        let name = name_and_weight[0];
        let weight = name_and_weight[1];

        *map.entry(String::from(name)).or_insert(0) += 1;

        if parts.len() > 1{
            let child_list: Vec<_> = parts[1].split(", ").collect();
            for child in child_list {
                *map.entry(String::from(child)).or_insert(0) += 1;
            }
        }
    }


    let single_map: HashMap<_,_> = map.iter().filter(|&(_, v)| *v == 1)
        .collect();
    println!("got {:?} only 1 time (as root)",single_map);
}
