use std::io::{BufRead, BufReader};
use std::fs::File;
use std::collections::HashMap;

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let input_lines: Vec<_> = input_file.lines().map(|line| { line.unwrap() }).collect();
    assert!(input_lines.len() > 0, "empty input");

    let mut value_map = HashMap::new();
    let mut total_max = 0;

    for line in input_lines {
        let parts: Vec<_> = line.split_whitespace().collect();
        assert!(parts.len() > 6, "malformed instruction");
        let identifier = parts[0];
        let operation = parts[1];
        let modifier = parts[2].parse::<i32>().ok().unwrap();
        let conditional = parts[3];
        let compare_indentifier = parts[4];
        let compare_op = parts[5];
        let compare_op_val = parts[6].parse::<i32>().ok().unwrap();

        let compare_val = *value_map.entry(String::from(compare_indentifier)).or_insert(0);

        let do_it = match compare_op {
            ">" =>  compare_val > compare_op_val,
            "<" => compare_val < compare_op_val,
            ">="   => compare_val >= compare_op_val,
            "<="   => compare_val <= compare_op_val,
            "=="   => compare_val == compare_op_val,
            "!="   => compare_val != compare_op_val,
            _ => panic!("unidentified instruction"),
        };

        if do_it {
            if operation == "inc" {
                *value_map.entry(String::from(identifier)).or_insert(0) += modifier;
            } else {
                *value_map.entry(String::from(identifier)).or_insert(0) -= modifier;
            }
            let current = *value_map.get(&String::from(identifier)).unwrap();
            if current > total_max {
                total_max = current;
            }

        }

    }

    println!("{:?}",value_map.iter().max_by(
        |&(lhs_key, lhs_value),&(rhs_key, rhs_value)|  lhs_value.cmp(rhs_value)
    ));

    println!("total max {}", total_max);


}
