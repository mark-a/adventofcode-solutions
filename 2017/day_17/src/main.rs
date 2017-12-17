fn main() {
    let mut buffer: Vec<i32> = vec![0];
    buffer.reserve_exact(49999999);
    let input: i32 = 343;
    let mut insert_point = 0;
    for i in 1..2018 {
        insert_point = (insert_point + input) % i;
        buffer.insert(insert_point as usize + 1, i);
        insert_point += 1;
    }

    let index = buffer.iter().position(|&r| r == 2017).unwrap();
    println!("after 2017 iterations after value \"2017\" there is {:?}", buffer[index + 1]);


    /* inserting in a buffer becomes inefficient fast
    the position of zero never changes so we only need
    to keep track of the value after that */
    let mut value_after_zero = 0;
    for i in 2018..50000000 {
        insert_point = (insert_point + input) % i;
        if insert_point == 0 {
            value_after_zero = i;
        }
        insert_point += 1;
    }


    println!(" after 50000000 iterations after value \"0\" there is {:?}", value_after_zero);
}
