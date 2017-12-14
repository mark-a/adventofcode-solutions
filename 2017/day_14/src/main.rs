use std::env;

mod knot_hash;

fn main() {
    let arguments: Vec<_> = env::args().collect();
    let step: String;
    if arguments.len() <= 1 {
        step = String::from("1");
    } else {
        step = arguments[1].clone();
    }
    let input: String;
    if arguments.len() <= 2 {
        input = String::from("hwlqcszp");
    } else {
        input = arguments[2].clone();
    }

    if step == "1" {
        let mut counter = 0;

        for i in 0..128 {
            let hash_input = format!("{}-{}", input, i);
            let hash_result = knot_hash::make_hash(hash_input);
            for hash_char in hash_result.chars() {
                let char_str = format!("{}", hash_char);
                let binary_val = format!("{:04b}", i32::from_str_radix(char_str.as_str(), 16).unwrap());
                for binary_char in binary_val.chars() {
                    if binary_char == '1' {
                        counter += 1;
                    }
                }
            }
        }

        println!("{}", counter);
        
    } else {
        let mut grid: [[i32; 128]; 128] = [[0; 128]; 128];

        for row in 0..128 {
            let hash_input = format!("{}-{}", input, row);
            let hash_result = knot_hash::make_hash(hash_input);
            for (col_part_1, hash_char) in hash_result.chars().enumerate() {
                let char_str = format!("{}", hash_char);
                let binary_val = format!("{:04b}", i32::from_str_radix(char_str.as_str(), 16).unwrap());
                for (col_part_2, binary_char) in binary_val.chars().enumerate() {
                    let col = col_part_1 * 4 + col_part_2;
                    if binary_char == '1' {
                        grid[col][row] = 1;
                    }
                }
            }
        }

        let mut current_group = 2;
        for x in 0..128 {
            for y in 0..128 {
                if try_paint(&mut grid, x, y, current_group) {
                    current_group += 1;
                }
            }
        }

        println!("total groups {}", current_group - 2);
    }
}

fn try_paint(working_grid: &mut [[i32; 128]; 128], x: usize, y: usize, color: i32) -> bool {
    if x >= 0 && x < 128 &&
        y >= 0 && y < 128 {
        let val = working_grid[x][y];
        if val != 0 && val < 2 {
            working_grid[x][y] = color;
            // try to paint neighbors recursive
            try_paint(working_grid, x - 1, y, color);
            try_paint(working_grid, x + 1, y, color);
            try_paint(working_grid, x, y - 1, color);
            try_paint(working_grid, x, y + 1, color);
            // has painted in the given color
            return true;
        }
        return false;
    }
    return false;
}

