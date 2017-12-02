use std::io::{BufRead, BufReader};
use std::fs::File;

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let mut input_lines: Vec<_> = input_file.lines().map(|line| { line.unwrap() }).collect();
    assert!(input_lines.len() > 0, "empty input");
 
    let mut check_sum = 0;

    for line in input_lines {
		let numbers: Vec<i32> = line.split_whitespace().filter_map(|n| n.parse::<i32>().ok()).collect();
		
		let mut dividers : Vec<(i32,i32)> = Vec::new();
		
		for number1 in numbers.clone() {
			for number2 in numbers.clone(){
				if number1 == number2 {
					continue;
				}
				
				if number1 % number2 == 0 {
					dividers.push((number1,number2));
				}
			}
		}
		
		let solution = dividers.pop().unwrap();
		
		let division_result = solution.0 / solution.1;
		check_sum += division_result;
    }


    println!("the solution is {}", check_sum);

}
