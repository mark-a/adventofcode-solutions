fn main()
{
    let input = include_str!("input_5");
    let mut seats = input.lines()
        .map(|s| s.bytes().fold(0, |a, x| 2 * a + (x == b'B' || x == b'R') as u16))
        .collect::<Vec<u16>>();

    seats.sort();
    println!("Solution 1: {}", seats.last().unwrap());

    let mut prev = seats[0];
    for s in seats.iter().skip(1)
    {
        if s - prev == 2
        {
            println!("Solution 2: {}", prev + 1);
            break;
        }
        prev = *s;
    }
}
