use std::iter::Iterator;

fn main() {
	let input = include_str!("input_3");
	let mut counts: [u32; 5] = [0; 5];
	let slopes: [(usize, usize); 5] = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)];
	for (i, line) in input.lines().enumerate() {
		for (slope, &(right, down)) in slopes.iter().enumerate() {
			if  (i % down == 0) &&
				(line.chars().cycle().nth((i / down)*right).unwrap() == '#') {
				counts[slope] += 1;
			}
		}
	}
	println!("Solution 1: {:?}", counts[1]);
	println!("Solution 2: {}", counts.iter().fold(1, |a, b| a*b));
}