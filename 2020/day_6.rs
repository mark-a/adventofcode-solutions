use std::collections::HashSet;

fn main() {
	let input = include_str!("input_6");
  
  let groups: Vec<Vec<HashSet<_>>> = input.split("\n\n")
            .map(|group| group.lines().map(|person| person.to_string().chars().collect::<HashSet<_>>() ).collect())
            .collect();
	
  
  
    let mut res_1 = 0;

    for group in &groups {
        let mut group_set = HashSet::new();
        for person in group {
            for element in person {
                group_set.insert(element);
            }
        }
        res_1 += group_set.len();
    }
    println!(
      "Part 1: {}",
      res_1
    );
    
    
    let mut res_2 = 0;

    for group in &groups {
        let mut group_set = group.iter().next().unwrap().clone();
        for person in group.iter().skip(1) {
            group_set.retain(|c| person.contains(c));
        }
        res_2 += group_set.len();
    }
        
    println!(
      "Part 2: {}",
      res_2
    );
}



