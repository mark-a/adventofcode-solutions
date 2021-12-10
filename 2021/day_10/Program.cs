(int, int)[] errors = { (0, 3), (0, 57), (0, 1197), (0, 25137) };

List<long> completionScores = new List<long>();

var values = new Dictionary<char, int>();
values.Add('(', 1);
values.Add('[', 2);
values.Add('{', 3);
values.Add('<', 4);

foreach (string line in File.ReadLines(@"input"))
{
    Stack<char> open = new Stack<char>();
    foreach (var ch in line)
    {
        switch ((open.FirstOrDefault(), ch))
        {
            // matching closing parenthesis:
            case ('(', ')'): open.Pop(); break;
            case ('[', ']'): open.Pop(); break;
            case ('{', '}'): open.Pop(); break;
            case ('<', '>'): open.Pop(); break;

            // count syntax error and discard line
            case (_, ')'): errors[0].Item1 += 1; goto end_of_loop;
            case (_, ']'): errors[1].Item1 += 1; goto end_of_loop;
            case (_, '}'): errors[2].Item1 += 1; goto end_of_loop;
            case (_, '>'): errors[3].Item1 += 1; goto end_of_loop;

            case (_, _): open.Push(ch); break;
        }
    }
    completionScores
        .Add(open
        .Select(item => values[item]) 
        .Aggregate((long) 0, (total, item) => total * 5 + item)
        );
end_of_loop: { }
}

Console.WriteLine("Stage 1: {0}", errors.Sum(x => x.Item1 * x.Item2));
Console.WriteLine("Stage 2: {0}", completionScores.OrderBy(x => x).ElementAt(completionScores.Count() / 2));