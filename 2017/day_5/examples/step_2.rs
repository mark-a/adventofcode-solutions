use std::collections::HashMap;
use std::io::{BufRead, BufReader};
use std::fs::File;

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let mut steps: Vec<_> = input_file.lines().map(
            |line| line.unwrap().parse::<i32>().ok().unwrap()).collect();
    let mut current :i32 = 0;
    let mut step_counter = 0;

    while (current as usize)  < steps.len()&& current >= 0 {
        let index = current as usize;
        let step_value = steps[index];
        if step_value > 2 {
            steps[index] -= 1;
        }else{
            steps[index] += 1;
        }
        current += step_value;
        step_counter+=1;
    }

    println!("steps taken: {}",step_counter);
}
