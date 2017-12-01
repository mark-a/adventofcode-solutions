use std::io::{BufRead, BufReader};
use std::fs::File;

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let mut input_lines: Vec<_> = input_file.lines().map(|line| { line.unwrap() }).collect();
    assert!(input_lines.len() > 0, "empty input");

    let workset: Vec<_> = input_lines[0].split("").filter_map(|n| n.parse::<i32>().ok()).collect();
    let mut sum = 0;
    for (i,digit) in workset.iter().enumerate() {
    	let next: usize = if i < workset.len() - 1 {
	  (i+1)  as usize
	} else{
	  0 as usize
	};

	if *digit == workset[next] {
	        println!("adding number at index {} because {} = {}", i, *digit, workset[next]);
		sum = sum + *digit;
	}

    }

    println!("the solution is {}", sum);

}
