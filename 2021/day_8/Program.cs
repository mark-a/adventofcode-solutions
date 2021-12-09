string[] input = File.ReadAllLines("input");

int count = input.Select(line => line.Split(" | ")[1])
.SelectMany(l => l.Split())
.Where(s => new[] { 2, 3, 4, 7 }.Contains(s.Length))
.Count();

Console.WriteLine("Stage 1: {0}", count);


int outputSum = input.Select(InvestigateAndParse).Sum();
Console.WriteLine("Stage 2: {0}", outputSum);

static int InvestigateAndParse(string line)
{
	var split = line.Split(" | ");
	var digits = split[0].Split();
	var number = split[1].Split();

	var one = digits.Single(x => x.Length == 2);
	var four = digits.Single(x => x.Length == 4);
	var seven = digits.Single(x => x.Length == 3);
	var eight = digits.Single(x => x.Length == 7);

	//deduct nine as 6 in length and only one field remaining when subtracting senven and four
	var nine = digits.Single(x => x.Length == 6 && x.Except(seven).Except(four).Count() == 1);

	// deduct six as 6 in length and not 9 and only one field remaining when subtracting from 1
	var six = digits.Single(x => x.Length == 6	&& x != nine && one.Except(x).Count() == 1);

	//  deduct zero as last 6 digit number
	var zero = digits.Single(x => x.Length == 6 && x != nine && x != six);

	// segment helper
	var down_left = eight.Except(nine).Single();
	var up_right = eight.Except(six).Single();
	var down_right = one.Except(new[] { up_right  }).Single();

	var five = digits.Single(x =>
		x.Length == 5
		&& !x.Contains(up_right)
		&& !x.Contains(down_left));

	// not five, but contains topright and not bottomright
	var two = digits.Single(x =>
		x.Length == 5
		&& x != five
		&& x.Contains(up_right)
		&& !x.Contains(down_left));
	// only five bar number left
	var three = digits.Single(x =>
		x.Length == 5
		&& x != five
		&& x != two);

	// for easy search below
	var numbers = new[]
	{
			(zero,0),
			(one,1),
			(two,2),
			(three,3),
			(four,4),
			(five,5),
			(six,6),
			(seven,7),
			(eight,8),
			(nine,9)
		};

	return number
		.Select(x => numbers.Where(n => n.Item1.Length == x.Length
				&& !n.Item1.Except(x).Any()
				&& !x.Except(n.Item1).Any())
			.Single())
		.Aggregate(0, (i, n) => i * 10 + n.Item2);
}