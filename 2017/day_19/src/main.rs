use std::io::{BufRead, BufReader};
use std::fs::File;

#[derive(PartialEq)]
enum Direction {
    Up,
    Down,
    Left,
    Right,
}

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let input_lines: Vec<_> = input_file.lines().map(|line| { line.unwrap() }).collect();
    assert!(input_lines.len() > 0, "empty input");

    let mut char_grid: Vec<Vec<char>> = Vec::new();
    for line in input_lines {
        char_grid.push(line.chars().collect());
    }

    let mut y: usize = 0;
    //starting point first pipe in the first line
    let mut x: usize = char_grid[y].iter().position(|&r| r == '|').unwrap();
    let mut current = '|';
    let mut direction = Direction::Down;
    let mut order = Vec::new();
    let mut step_count = 0;
    loop {
        match direction {
            Direction::Down => {
                if y + 1 >= char_grid.len() {
                    break;
                }
                y += 1;
            }
            Direction::Up => {
                if y <= 0 {
                    break;
                }
                y -= 1;
            }
            Direction::Left => {
                if x <= 0 {
                    break;
                }
                x -= 1;
            }
            Direction::Right => {
                if x + 1 >= char_grid[y].len() {
                    break;
                }
                x += 1;
            }
        };

        current = char_grid[y][x];
        step_count += 1;

        if current.is_alphabetic() {
            order.push(current);
        }

        if current == '+' {
            if direction == Direction::Up || direction == Direction::Down {
                if x > 0 && char_grid[y][x - 1] != ' ' {
                    direction = Direction::Left;
                } else if x + 1 < char_grid[y].len() && char_grid[y][x + 1] != ' ' {
                    direction = Direction::Right;
                }
            } else if direction == Direction::Left || direction == Direction::Right {
                if y > 1 && char_grid[y - 1].len() > x && char_grid[y - 1][x] != ' ' {
                    direction = Direction::Up;
                } else if y + 1 < char_grid.len() && char_grid[y + 1].len() > x && char_grid[y + 1][x] != ' ' {
                    direction = Direction::Down;
                }
            }
        }
        if current == ' ' {
            break;
        }
    };
    let order_string :String = order.into_iter().collect();
    println!("at {} {} {} {:?} with {} steps", x, y, current, order_string,step_count);
}