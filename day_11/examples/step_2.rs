use std::io::{BufRead, BufReader};
use std::fs::File;

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let input_lines: Vec<_> = input_file.lines().map(|line| { line.unwrap() }).collect();
    assert!(input_lines.len() > 0, "empty input");
    let moves: Vec<String> = input_lines[0].split(",").map(|s| String::from(s)).collect();

    let mut x :i32 = 0;
    let mut y :i32 = 0;
    let mut z :i32 = 0;

    let mut max_x :i32 = 0;
    let mut max_y :i32 = 0;
    let mut max_z :i32 = 0;

    for movement in moves {
        match movement.as_ref() {
            "n" => {
                y += 1;
                z -= 1;
            }
            "s" => {
                y -= 1;
                z += 1;
            }
            "ne" => {
                x += 1;
                z -= 1;
            }
            "nw" => {
                x -= 1;
                y += 1;
            }
            "se" => {
                x += 1;
                y -= 1;
            }
            "sw" => {
                x -= 1;
                z += 1;
            }
            _ => {}
        }
        if x.abs() > max_x {
            max_x = x;
        }
        if y.abs() > max_y {
            max_y = y;
        }
        if z.abs() > max_z {
            max_z = z;
        }
    }

    let mut sorter = vec![max_x.abs(),max_y.abs(),max_z.abs()];
    sorter.sort_by(|a, b| b.cmp(a));

    // biggest direction on the 3 dimensional cube
    println!("stepped a maximum of {} steps away", sorter[0]);
}
