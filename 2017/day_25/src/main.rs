use std::collections::HashMap;

#[derive(Copy, Clone)]
struct Instruction {
    write_one: bool,
    move_right: bool,
    next_state: char,
}

#[derive(Copy, Clone)]
struct State {
    if_zero: Instruction,
    if_one: Instruction,
}

fn main() {
    let states: HashMap<char, State> =
        [
            ('A', State {
                if_zero: Instruction {
                    write_one: true,
                    move_right: true,
                    next_state: 'B',
                },
                if_one: Instruction {
                    write_one: false,
                    move_right: false,
                    next_state: 'C',
                },
            }),
            ('B', State {
                if_zero: Instruction {
                    write_one: true,
                    move_right: false,
                    next_state: 'A',
                },
                if_one: Instruction {
                    write_one: true,
                    move_right: false,
                    next_state: 'D',
                },
            }),
            ('C', State {
                if_zero: Instruction {
                    write_one: true,
                    move_right: true,
                    next_state: 'D',
                },
                if_one: Instruction {
                    write_one: false,
                    move_right: true,
                    next_state: 'C',
                },
            }),
            ('D', State {
                if_zero: Instruction {
                    write_one: false,
                    move_right: false,
                    next_state: 'B',
                },
                if_one: Instruction {
                    write_one: false,
                    move_right: true,
                    next_state: 'E',
                },
            }),
            ('E', State {
                if_zero: Instruction {
                    write_one: true,
                    move_right: true,
                    next_state: 'C',
                },
                if_one: Instruction {
                    write_one: true,
                    move_right: false,
                    next_state: 'F',
                },
            }),
            ('F', State {
                if_zero: Instruction {
                    write_one: true,
                    move_right: false,
                    next_state: 'E',
                },
                if_one: Instruction {
                    write_one: true,
                    move_right: true,
                    next_state: 'A',
                },
            }),
        ].iter().cloned().collect();

    let counter = run_machine(states, 12656374);


    println!("found {} ones", counter);
}

fn run_machine(states: HashMap<char, State>, num_iterations: usize) -> i32 {
    let mut current_state = 'A';
    let mut current_position = 0;
    let mut tape: HashMap<i32, bool> = HashMap::new();

    for _ in 0..num_iterations {
        let instruction = states.get(&current_state).unwrap();
        let current_value = tape.entry(current_position).or_insert(false);

        if *current_value {
            *current_value = instruction.if_one.write_one;
            if instruction.if_one.move_right {
                current_position += 1;
            } else {
                current_position -= 1;
            }
            current_state = instruction.if_one.next_state;
        } else {
            *current_value = instruction.if_zero.write_one;
            if instruction.if_zero.move_right {
                current_position += 1;
            } else {
                current_position -= 1;
            }
            current_state = instruction.if_zero.next_state;
        }
    }

    let mut checksum = 0;
    for (_, value) in &tape {
        if *value {
            checksum += 1
        }
    }
    checksum
}

#[test]
fn example_machine() {
    let states: HashMap<char, State> =
        [
            ('A', State {
                if_zero: Instruction {
                    write_one: true,
                    move_right: true,
                    next_state: 'B',
                },
                if_one: Instruction {
                    write_one: false,
                    move_right: false,
                    next_state: 'B',
                },
            }),
            ('B', State {
                if_zero: Instruction {
                    write_one: true,
                    move_right: false,
                    next_state: 'A',
                },
                if_one: Instruction {
                    write_one: true,
                    move_right: true,
                    next_state: 'A',
                },
            }),
        ].iter().cloned().collect();


    assert_eq!(run_machine(states, 6), 3);
}