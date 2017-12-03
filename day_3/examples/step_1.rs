use std::collections::HashMap;
use std::env;

fn main() {
    let arguments: Vec<_> = env::args().collect();
    assert!(arguments.len() > 1, "input as param please");

    let input = arguments[1].parse::<i32>().ok().unwrap();
    let mut grid_entries = HashMap::new();

    let mut current_x = 0;
    let mut current_y = 0;

    let mut delta_x = 0;
    let mut delta_y= -1;

    //fill map coordinates
    for i in 1..input + 1 {

        grid_entries.insert(i,(current_x,current_y));

        // spiral walk algorithm
        if current_x == current_y ||
            (current_x < 0 && current_x == -current_y) ||
            (current_x > 0 && current_x == 1-current_y){
            let temp = delta_x;
            delta_x = -delta_y;
            delta_y = temp;
        }

        current_x += delta_x;
        current_y += delta_y;
    }

    let solution_coordinates = grid_entries.get(&input).unwrap();

    let final_value = (solution_coordinates.0 as i32).abs() + (solution_coordinates.1 as i32).abs();

    println!("{}: {:?} -> {} steps",input,solution_coordinates,final_value);
}
