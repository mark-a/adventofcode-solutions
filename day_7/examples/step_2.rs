use std::io::{BufRead, BufReader};
use std::fs::File;
use std::collections::HashMap;

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let input_lines: Vec<_> = input_file.lines().map(|line| { line.unwrap() }).collect();
    assert!(input_lines.len() > 0, "empty input");

    let mut count_map = HashMap::new();
    let mut weight_map = HashMap::new();
    let mut root_map = HashMap::new();
    let mut child_map = HashMap::new();

    for line in input_lines {
        let parts: Vec<_> = line.split(" -> ").collect();

        let name_and_weight :Vec<_> = parts[0].split_whitespace().collect();
        let name = name_and_weight[0];
        let mut weight = name_and_weight[1];
        weight = &weight[1..];
        weight = &weight[..weight.len()-1];

        *count_map.entry(String::from(name)).or_insert(0) += 1;
        *weight_map.entry(String::from(name)).or_insert(weight.parse::<i32>().ok().unwrap());

        if parts.len() > 1{

            let child_list: Vec<_> = parts[1].split(", ").collect();
            for child in child_list {
                *count_map.entry(String::from(child)).or_insert(0) += 1;
                child_map.entry(String::from(name)).or_insert(Vec::new()).push(String::from(child));
                root_map.insert(String::from(child),String::from(name));
            }
        }
    }


    let single_map: HashMap<_,_> = count_map.iter().filter(|&(_, v)| *v == 1)
        .collect();
    let root_key = single_map.keys().next().unwrap().clone();

    let mut current_level = 0;
    let mut work_nodes = vec![root_key];
    let mut levels:Vec<Vec<String>> = Vec::new();
    levels.push(Vec::new());
    while work_nodes.len() > 0{
        let current = work_nodes.pop().unwrap();
        levels[current_level].push(current.clone());

        if work_nodes.len() == 0 {
            current_level+= 1;
            levels.push(Vec::new());
        }
        if let Some(children)  = child_map.get(current) {
            for child in children {
                work_nodes.push(child);
                let root_name = root_map.get(child).unwrap();
              //  *weight_map.entry(root_name.clone()).or_insert(0) += *weight_map.get(child ).unwrap();
            }
        }


    }

    println!("{:?}",levels);

}
