
fn main() {
    let raw_input =  include_str!("input_14");

    println!("Solution 1: {}", part1(raw_input));
    println!("Solution 2: {}", part2(raw_input));
}

use std::collections::HashMap;

enum Instruction {
    Mask(u64, u64, u64),
    Mem(u64, u64),
}

pub fn part1(input: &str) -> impl std::fmt::Display {
    input
        .lines()
        .map(Instruction::from)
        .fold(((0, 0, 0), HashMap::new()), |(mut mask, mut mem), ins| {
            match ins {
                Instruction::Mask(z, o, x) => mask = (z, o, x),
                Instruction::Mem(addr, val) => {
                    mem.insert(addr, val & !mask.0 | mask.1);
                }
            }
            (mask, mem)
        })
        .1
        .values()
        .sum::<u64>()
}

pub fn part2(input: &str) -> impl std::fmt::Display {
    input
        .lines()
        .map(Instruction::from)
        .fold(((0, 0, 0), HashMap::new()), |(mut mask, mut mem), ins| {
            match ins {
                Instruction::Mask(z, o, x) => mask = (z, o, x),
                Instruction::Mem(addr, val) => {
                    decode(addr, mask.1, mask.2).into_iter().for_each(|a| {
                        mem.insert(a, val);
                    });
                }
            }
            (mask, mem)
        })
        .1
        .values()
        .sum::<u64>()
}

fn decode(addr: u64, o: u64, x: u64) -> Vec<u64> {
    (0..64)
        .filter(|i| (1 << i) & x > 0)
        .fold(vec![addr | o], |acc, i| {
            acc.into_iter()
                .flat_map(|j| vec![j & !(1 << i), j | (1 << i)])
                .collect()
        })
}

impl From<&str> for Instruction {
    fn from(s: &str) -> Self {
        if s.starts_with("mask") {
            let m = ['0', '1', 'X']
                .iter()
                .map(|c| {
                    s.chars()
                        .skip(7)
                        .map(|d| if *c == d { 1 } else { 0 })
                        .fold(0, |acc, x| acc * 2 + x)
                })
                .collect::<Vec<_>>();
            Instruction::Mask(m[0], m[1], m[2])
        } else {
            let mut s = s.strip_prefix("mem[").unwrap().split(']');
            let addr = s.next().unwrap().parse().unwrap();
            let val = s.next().unwrap().split_at(3).1.parse().unwrap();
            Instruction::Mem(addr, val)
        }
    }
}

