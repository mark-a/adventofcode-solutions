using System.Text.RegularExpressions;

var input = File.ReadLines(@"input")
        .Select(l => Regex.Match(l, @"(\d+),(\d+) -> (\d+),(\d+)"))
        .Select(match => (
            x1: Int32.Parse(match.Groups[1].Value),
            y1: Int32.Parse(match.Groups[2].Value),
            x2: Int32.Parse(match.Groups[3].Value),
            y2: Int32.Parse(match.Groups[4].Value))
            )
        .ToList();


Console.WriteLine($"Stage 1: {CountDoubles(input, skipDiagonals: true)}");
Console.WriteLine($"Stage 2: {CountDoubles(input, skipDiagonals: false)}");

static int CountDoubles(List<(int x1, int y1, int x2, int y2)> lines, bool skipDiagonals)
{
    return lines.Where(x => !skipDiagonals || x.x1 == x.x2 || x.y1 == x.y2)
        .SelectMany(x => PointsForLine(x.x1, x.y1, x.x2, x.y2))
        .GroupBy(x => x)
        .Where(g => g.Count() > 1)
        .Count();
}

static IEnumerable<(int x, int y)> PointsForLine(int x1, int y1, int x2, int y2)
{
    var dx = Math.Sign(x2 - x1);
    var dy = Math.Sign(y2 - y1);
    for (int x = x1, y = y1; x != (x2 + dx) || y != (y2 + dy); x += dx, y += dy)
    {
        yield return (x, y);
    }
}