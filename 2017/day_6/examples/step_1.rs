use std::io::{BufRead, BufReader};
use std::fs::File;
use std::cmp::Reverse;

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let input_lines: Vec<_> = input_file.lines().map(|line| { line.unwrap() }).collect();
    assert!(input_lines.len() > 0, "empty input");
    let mut numbers: Vec<i32> = input_lines[0].split_whitespace().filter_map(
        |n| n.parse::<i32>().ok()
    ).collect();
    let length = numbers.len();


    let mut seen: Vec<_> = Vec::new();
    let mut step_counter = 0;

    while !seen.contains(&format!("{:?}", numbers)) {
        seen.push(format!("{:?}", numbers));

        let copy = numbers.clone();
        let max_element = copy.iter().enumerate().max_by(|&(lhs_i, lhs),&(rhs_i, rhs)| {
            if lhs == rhs {
                Reverse(lhs_i).cmp(&Reverse(rhs_i))
            }else{
                lhs.cmp(rhs)
            }
        });
        let (max_element_index,max_element_value) = max_element.unwrap();
        numbers[max_element_index] = 0;
        for offset in 1..max_element_value + 1 {
            numbers[(max_element_index+offset as usize) % length] += 1;
        }
        step_counter+=1;
    }

    println!("looping after {} steps", step_counter);
}
