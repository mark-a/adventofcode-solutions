struct Generator {
    factor: i64,
    value: i64,
}

impl Generator {
    fn next(&mut self) -> i64{
        self.value = (self.value * self.factor) % 2147483647;
        return self.value;
    }
}


fn main() {
    let mut gen_a = Generator{
        factor: 16807,
        //value: 65,
        value: 591,
    };
    let mut gen_b = Generator {
        factor: 48271,
        //value: 8921,
        value: 393,
    };

    let mut counter = 0;
    for i in 0..40000000 {
        if i % 1000000 == 0 {
            println!("processed {}",i);
        }
        let a_binary = format!("{:032b}",gen_a.next());
        let b_binary = format!("{:032b}",gen_b.next());
        if a_binary[16..] == b_binary[16..] {
            counter += 1;
        }
    }
    println!("{}",counter);
}