use std::io::{BufRead, BufReader};
use std::fs::File;
use std::collections::HashMap;

#[derive(Copy, Clone, Eq, PartialEq, Hash)]
struct Point(i32, i32);

impl Point {
    fn add(&mut self, rhs: Point) {
        self.0 += rhs.0;
        self.1 += rhs.1;
    }
}

struct Carrier {
    pos: Point,
    dir: Point,
    map: HashMap<Point, bool>,
    infected: usize,
}

impl Carrier {

    fn burst(&mut self) {
        let infected = self.map.entry(self.pos).or_insert(false);

        if *infected {
            self.dir = match self.dir {
                Point(0, 1) => Point(-1, 0),
                Point(0, -1) => Point(1, 0),
                Point(1, 0) => Point(0, 1),
                Point(-1, 0) => Point(0, -1),
                _ => Point(0, 0),
            };
            *infected = false;
        } else {
            self.infected += 1;
            self.dir = match self.dir {
                Point(0, 1) => Point(1, 0),
                Point(0, -1) => Point(-1, 0),
                Point(1, 0) => Point(0, -1),
                Point(-1, 0) => Point(0, 1),
                _ => Point(0, 0),
            };
            *infected = true;
        }

        self.pos.add(self.dir);
    }
}

fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let input_lines: Vec<_> = input_file.lines()
        .map(|line| { line.unwrap() })
        .collect();

    let mut map = HashMap::new();
    for (y, l) in input_lines.iter().enumerate() {
        let offset = ((l.len() as i32) - 1) / 2;
        let y = (y as i32) - offset;
        for (x, c) in l.chars().enumerate() {
            let x = (x as i32) - offset;
            map.insert(Point(x, y), if c == '#' { true } else { false });
        }
    }
    let mut carrier =   Carrier {
        infected: 0,
        dir: Point(0, -1),
        pos: Point(0, 0),
        map: map,
    };
    for _ in 0..10_000 {
        carrier.burst();
    }
    println!("infected: {}",carrier.infected);
}
