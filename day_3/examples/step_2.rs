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

    let mut insert_value = 0;


    for _ in 1..input + 1 {

        insert_value = 0;

        //neighor value check
        for x in [-1,0,1].iter() {
            for y in [-1,0,1].iter(){
                if *x == 0 && *y == 0 {
                    continue;
                }

                if let Some(neighbor) = grid_entries.get(&(current_x + *x, current_y+ *y)) {
                    insert_value += *neighbor;
                }
            }
        }

        if insert_value == 0 {
            insert_value = 1;
        }

        //fill map coordinates
        grid_entries.insert((current_x,current_y),insert_value);
        println!("{:?} : {}",(current_x,current_y),insert_value);

        if insert_value > input {
            break;
        }

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

    println!("first value larger than {} ({}) written  at {:?}",input,insert_value,(current_x,current_y));
}
