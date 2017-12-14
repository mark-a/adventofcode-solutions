use std::io::{BufRead, BufReader};
use std::fs::File;
use std::cmp;

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let input_lines: Vec<_> = input_file.lines().map(|line| { line.unwrap() }).collect();
    assert!(input_lines.len() > 0, "empty input");
    let input_lengths: Vec<usize> = input_lines[0].split(",").filter_map(|n| n.parse::<usize>().ok()).collect();

    let mut work_array = [0; 256];
    for i in  0..256 {
        work_array[i] = i;
    }

    let mut skip = 0;
    let mut position= 0;
    for input in input_lengths {
        println!("{:?}",work_array.to_vec());
        let max =  cmp::min(work_array.len() - position, input);
        let wrapped = input - max;
        let mut take = vec![];
        take.extend_from_slice(&work_array[position..position+max]);
        take.extend_from_slice(&work_array[..wrapped]);
        take.reverse();
        println!("{:?}",take);
        for (i, number) in take.iter().enumerate(){
            let input_point = (position + i) % work_array.len();
            work_array[input_point] = *number;
        }

        position =  (position + input + skip) % work_array.len();
        skip += 1;
    }

    println!("{} * {} = {}", work_array[0],work_array[1],work_array[0] * work_array[1])



}
