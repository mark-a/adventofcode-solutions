use std::fs::File;
use std::io::Read;
use std::path::Path;
use std::time::Instant;

#[derive(Debug, Copy, Clone, Eq, PartialEq)]
pub enum Rotation {
    None,
    Right,
    Left,
    Back,
}

impl Rotation {
    pub fn rotate(self, waypoint: (i32, i32)) -> (i32, i32) {
        match self {
            Rotation::None => (waypoint.0, waypoint.1),
            Rotation::Right => (-waypoint.1, waypoint.0),

            Rotation::Left => (waypoint.1, -waypoint.0),
            Rotation::Back => (-waypoint.0, -waypoint.1)
        }
    }
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
pub struct Ship {
    position: (i32, i32),
    waypoint: (i32, i32),
}

impl Ship {
    pub fn new() -> Ship {
        Ship {
            position: (0, 0),
            waypoint: (1, 10),
        }
    }

    pub fn advance(&mut self, dir: Direction) {
        match dir {
            Direction::N(x) => self.waypoint.0 += x,
            Direction::E(x) => self.waypoint.1 += x,
            Direction::S(x) => self.waypoint.0 -= x,
            Direction::W(x) => self.waypoint.1 -= x,
            Direction::F(x) => {
                self.position.0 += self.waypoint.0 * x;
                self.position.1 += self.waypoint.1 * x;
            }
            Direction::R(r) => self.waypoint = r.rotate(self.waypoint),
        }
    }

    pub fn distance(&self) -> i32 {
        self.position.0.abs() + self.position.1.abs()
    }
}


fn main() {
    let raw_input = load_input_data("input_12");
    let input = parse_input_data(raw_input);

    let start = Instant::now();
    let solution = solve_part_two(&input);
    let duration = start.elapsed();
    println!("Solution '{}' computed in {} us", solution, duration.as_micros());
}

fn load_input_data<P: AsRef<Path>>(path: P) -> String {
    let mut file = File::open(path).unwrap();
    let mut buffer = String::with_capacity(1024 * 3);

    file.read_to_string(&mut buffer).unwrap();
    buffer
}

fn parse_input_data(input: String) -> Vec<Direction> {
    let mut data = Vec::with_capacity(800);
    for line in input.lines() {
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

fn solve_part_two(input: &[Direction]) -> i32 {
    let mut position = Ship::new();

    for direction in input.iter().copied() {
        position.advance(direction);
    }

    return position.distance();
}
