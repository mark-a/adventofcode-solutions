use std::cmp;

pub fn make_hash(input_line: String) -> String{

    let mut input_lengths: Vec<usize> = input_line.chars().filter_map(|n|
        Some(n as usize)
    ).collect();
    let mut added = vec![17, 31, 73, 47, 23];
    input_lengths.append(&mut added);

    let mut work_array = [0; 256];
    for i in 0..256 {
        work_array[i] = i;
    }

    let mut skip = 0;
    let mut position = 0;

    for _ in 0..64 {
        for input in &input_lengths {
            let max = cmp::min(work_array.len() - position, *input);
            let wrapped = input - max;
            let mut take = vec![];
            take.extend_from_slice(&work_array[position..position + max]);
            take.extend_from_slice(&work_array[..wrapped]);
            take.reverse();

            for (i, number) in take.iter().enumerate() {
                let input_point = (position + i) % work_array.len();
                work_array[input_point] = *number;
            }

            position = (position + input + skip) % work_array.len();
            skip += 1;
        }
    }

    let mut numbers = Vec::new();

    for i in 0..16 {
        let mut val:usize = 0;
        for x in work_array[i*16 .. i*16+16].iter(){
            val ^= *x;
        }
        numbers.push(format!("{:02x}", val));
    }

    return numbers.join("");
}