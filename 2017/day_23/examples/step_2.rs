fn main() {
    let mut result = 0;
    let mut i: usize = 108400;
    while i <= 125400 {
        if !is_prime(i) {
            result += 1;
        }
        i += 17;
    }
    println!("number of primes between 108400 and 125400 with step size 17: {}", result);
}

fn is_prime(number: usize) -> bool {
    for factor in 2..number {
        if (number % factor) == 0 {
            return false;
        }
    }
    return true;
}
