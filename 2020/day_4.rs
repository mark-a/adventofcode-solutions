use std::ops::RangeInclusive;

fn main() {
	let input = include_str!("input_4");
	
    println!(
        "Part 1: {}",
			input
            .split("\n\n")
            .filter(|passport| {
                let fields = passport.split_whitespace();
                let keys = fields.map(|field| field.split(":").next());
                keys.filter(|&key| key != Some("cid")).count() == 7
            })
            .count()
    );
	
	println!(
        "Part 2: {}",
			input
            .split("\n\n")
            .filter(|passport| passport.split_whitespace().filter(is_valid_field).count() == 7)
            .count()
    );
}




fn is_valid_field(field: &&str) -> bool {
    let mut kv = field.split(":");
    let k = kv.next().unwrap();
    let v = kv.next().unwrap();
    match k {
        "byr" => is_in_range(v, 1920..=2002),
        "iyr" => is_in_range(v, 2010..=2020),
        "eyr" => is_in_range(v, 2010..=2030),
        "hgt" => is_in_range_suffixed(v, 150..=193, "cm") || is_in_range_suffixed(v, 59..=76, "in"),
        "hcl" => v
            .strip_prefix("#")
            .map_or(false, |rest| rest.chars().all(|c| c.is_ascii_hexdigit())),
        "ecl" => matches!(v, "amb" | "blu" | "brn" | "gry" | "grn" | "hzl" | "oth"),
        "pid" => v.len() == 9 && v.chars().all(|c| c.is_ascii_digit()),
        _ => false,
    }
}

fn is_in_range(s: &str, range: RangeInclusive<u16>) -> bool {
    s.parse().map_or(false, |n: u16| range.contains(&n))
}

fn is_in_range_suffixed(s: &str, range: RangeInclusive<u16>, suffix: &str) -> bool {
    s.strip_suffix(suffix)
        .map_or(false, |rest| is_in_range(rest, range))
}