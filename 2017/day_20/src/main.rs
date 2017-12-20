use std::io::{BufRead, BufReader};
use std::fs::File;
use std::collections::HashMap;

extern crate regex;

use regex::Regex;

#[derive(Debug)]
struct Particle {
    position: (i64, i64, i64),
    acceleration: (i64, i64, i64),
    velocity: (i64, i64, i64),
    index: usize,
    destroyed: bool,
}

impl Particle {
    fn tick(&mut self) {
        self.velocity.0 += self.acceleration.0;
        self.velocity.1 += self.acceleration.1;
        self.velocity.2 += self.acceleration.2;
        self.position.0 += self.velocity.0;
        self.position.1 += self.velocity.1;
        self.position.2 += self.velocity.2;
    }

    fn distance_to_origin(&self) -> i64 {
        self.position.0.abs() +
            self.position.1.abs() +
            self.position.2.abs()
    }
}


fn main() {
    let input_file = BufReader::new(File::open("input").unwrap());
    let input_lines: Vec<_> = input_file.lines().map(|line| { line.unwrap() }).collect();
    assert!(input_lines.len() > 0, "empty input");

    let mut particles: Vec<Particle> = Vec::new();
    let particle_regex = Regex::new(r"p=<(-?\d+),(-?\d+),(-?\d+)>, v=<(-?\d+),(-?\d+),(-?\d+)>, a=<(-?\d+),(-?\d+),(-?\d+)>").unwrap();

    let mut particle_counter = -1;
    for line in input_lines {
        particle_counter += 1;
        for cap in particle_regex.captures_iter(&line) {
            particles.push(Particle {
                index: particle_counter as usize,
                destroyed: false,
                position: (cap[1].parse::<i64>().unwrap(),
                           cap[2].parse::<i64>().unwrap(),
                           cap[3].parse::<i64>().unwrap()),
                velocity: (cap[4].parse::<i64>().unwrap(),
                           cap[5].parse::<i64>().unwrap(),
                           cap[6].parse::<i64>().unwrap()),
                acceleration: (cap[7].parse::<i64>().unwrap(),
                               cap[8].parse::<i64>().unwrap(),
                               cap[9].parse::<i64>().unwrap()),

            });
        }
    }
    let max = 10000;
    for _ in 0..max {
        let mut collision_scanner = HashMap::new();
        for particle in &mut particles {
            particle.tick();
            if !particle.destroyed {
                let seen_count = collision_scanner.entry((particle.position.0,
                                                          particle.position.1,
                                                          particle.position.2)
                ).or_insert((0, Vec::new()));
                (*seen_count).0 += 1;
                (*seen_count).1.push(particle.index);
            }
        }
        for (position, (count, par_indices)) in collision_scanner.into_iter() {
            if count > 1 {
                for i in par_indices {
                    particles[i].destroyed = true;
                }
            }
        }
    }

    let p_min = &particles.iter().min_by(|a, b| a.distance_to_origin().cmp(&b.distance_to_origin()));
    println!("min after {} steps: {:?}",max, p_min);

    let mut num_alive = 0;
    for particle in &particles {
        if !particle.destroyed {
            num_alive += 1;
        }
    }
    println!("alive count after {} steps: {}",max, num_alive);
}
