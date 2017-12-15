struct Generator {
    factor: i64,
    value: i64,
    modulo : i64,
}

impl Generator {
    fn next(&mut self) -> i64{
        let mut changed = false;
        while self.value % self.modulo != 0 || changed == false {
            self.value = (self.value * self.factor) % 2147483647;
            changed = true;
        }
        return self.value;
    }
}


fn main() {
    let mut gen_a = Generator{
        factor: 16807,
        //value: 65,
        value: 591,
        modulo: 4,
    };
    let mut gen_b = Generator {
        factor: 48271,
        //value: 8921,
        value: 393,
        modulo:8,
    };

    let mut counter = 0;
    for i in 0..5000000 {
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