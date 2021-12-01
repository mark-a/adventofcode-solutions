use std::fs::File;
use std::io::Read;
use std::path::Path;
use std::time::Instant;

#[derive(Debug, Copy, Clone, Eq, PartialEq)]
pub enum Orientation {
    N,
    E,
    S,
    W,
}

impl Orientation {
    pub fn rotate(self, rot: Rotation) -> Orientation {
        match self {
            Orientation::N => match rot {
                Rotation::None => Orientation::N,
                Rotation::Right => Orientation::E,
                Rotation::Left => Orientation::W,
                Rotation::Back => Orientation::S,
            }
            Orientation::E => match rot {
                Rotation::None => Orientation::E,
                Rotation::Right => Orientation::S,
                Rotation::Left => Orientation::N,
                Rotation::Back => Orientation::W,
            }
            Orientation::S => match rot {
                Rotation::None => Orientation::S,
                Rotation::Right => Orientation::W,
                Rotation::Left => Orientation::E,
                Rotation::Back => Orientation::N,
            }
            Orientation::W => match rot {
                Rotation::None => Orientation::W,
                Rotation::Right => Orientation::N,
                Rotation::Left => Orientation::S,
                Rotation::Back => Orientation::E,
            }
        }
    }

    pub fn advance(self, mut position: (i32, i32), value: i32) -> (i32, i32) {
        match self {
            Orientation::N => position.0 += value,
            Orientation::E => position.1 += value,
            Orientation::S => position.0 -= value,
            Orientation::W => position.1 -= value,
        }

        position
    }
}

#[derive(Debug, Copy, Clone, Eq, PartialEq)]
pub enum Rotation {
    None,
    Right,
    Left,
    Back,
}

#[derive(Debug, Copy, Clone, Eq, PartialEq)]
pub enum Direction {
    N(i32),
    E(i32),
    S(i32),
    W(i32),
    F(i32),
    R(Rotation),
}

#[derive(Debug, Copy, Clone, Eq, PartialEq)]
pub struct Position {
    orientation: Orientation,
    position: (i32, i32),
}

impl Position {
    pub fn new() -> Position {
        Position {
            orientation: Orientation::E,
            position: (0, 0),
        }
    }

    pub fn advance(&mut self, dir: Direction) {
        match dir {
            Direction::N(x) => self.position.0 += x,
            Direction::E(x) => self.position.1 += x,
            Direction::S(x) => self.position.0 -= x,
            Direction::W(x) => self.position.1 -= x,
            Direction::F(x) => self.position = self.orientation.advance(self.position, x),
            Direction::R(r) => self.orientation = self.orientation.rotate(r),
        }
    }

    pub fn distance(&self) -> i32 {
        self.position.0.abs() + self.position.1.abs()
    }
}


fn main() {
    let raw_input = include_str!("input_12").to_string();
    let input = parse_input_data(raw_input);

    let start = Instant::now();
    let solution = solve_part_one(&input);
    let duration = start.elapsed();
    println!("Solution '{}' computed in {} us", solution, duration.as_micros());
}


fn parse_input_data(input: String) -> Vec<Direction> {
	let lines: Vec<_> = input.lines().collect();
    let mut data = Vec::with_capacity(lines.len());
    for line in lines {
        let value = line[1..].parse().unwrap();
        match &line[..1] {
            "N" => data.push(Direction::N(value)),
            "S" => data.push(Direction::S(value)),
            "E" => data.push(Direction::E(value)),
            "W" => data.push(Direction::W(value)),
            "F" => data.push(Direction::F(value)),
            "L" => {
                let rotation = match value {
                    90 => Rotation::Left,
                    180 => Rotation::Back,
                    270 => Rotation::Right,
                    360 => Rotation::None,
                    _ => panic!("Unexpected rotation: {}", line),
                };
                data.push(Direction::R(rotation));
            }
            "R" => {
                let rotation = match value {
                    90 => Rotation::Right,
                    180 => Rotation::Back,
                    270 => Rotation::Left,
                    360 => Rotation::None,
                    _ => panic!("Unexpected rotation: {}", line),
                };
                data.push(Direction::R(rotation));
            }
            _ => panic!("Invalid input: {}", line),
        }
    }
    data
}

fn solve_part_one(input: &[Direction]) -> i32 {
    let mut position = Position::new();

    for direction in input.iter().copied() {
        position.advance(direction);
    }

    return position.distance();
}
