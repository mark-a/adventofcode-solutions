use std::env;
mod knot_hash;

fn main() {
    let arguments: Vec<_> = env::args().collect();
    let mut input :String;
    if arguments.len() <= 1 {
        input = String::from("hwlqcszp");
    }
    else {
        input = arguments[1].clone();
    }
    let mut counter = 0;
    for i in 0..128 {
        let hash_input = format!("{}-{}",input,i);
        let hash_result = knot_hash::make_hash(hash_input);
        for hash_char in hash_result.chars() {
            let char_str = format!("{}",hash_char);
            let binary_val = format!("{:04b}",i32::from_str_radix(char_str.as_str(), 16).unwrap());
            for binary_char in binary_val.chars() {
                if binary_char == '1' {
                    counter += 1;
                }
            }
        }
    }
    println!("{}",counter);
}
