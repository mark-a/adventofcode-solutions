use std::io::{BufRead, BufReader};
use std::fs::File;

fn main() {
    let input_file = BufReader::new(File::open("input.txt").unwrap());
    let mut input_lines: Vec<_> = input_file.lines().map(|line| { line.unwrap() }).collect();
    assert!(input_lines.len() > 0, "empty input");

    let mut check_sum = 0;

    for line in input_lines {
        let numbers: Vec<i32> = line.split_whitespace().filter_map(|n| n.parse::<i32>().ok()).collect();
        let min = numbers.iter().min().unwrap();
        let max = numbers.iter().max().unwrap();
        println!("min: {} max: {}", min, max);
        let sum = *max - *min;
        check_sum += sum;
    }


    println!("the solution is {}", check_sum);
}
