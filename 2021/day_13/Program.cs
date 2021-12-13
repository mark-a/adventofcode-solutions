using System.Text.RegularExpressions;

string test = @"6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5";


//string[] parts = Regex.Split(test, @"\r\n\r\n");
string[] parts = Regex.Split(File.ReadAllText("input"), @"\n\n");

List<(int x, int y)> dots = new List<(int x, int y)>();

StringReader dot_reader = new StringReader(parts[0]);
string line;
int max_x = 0;
int max_y = 0;
while ((line = dot_reader.ReadLine()) != null)
{
    var line_parts = line.Split(",");
    int x = Int32.Parse(line_parts[0]);
    int y = Int32.Parse(line_parts[1]);
    dots.Add((x, y));
    if (x > max_x) max_x = x;
    if (y > max_y) max_y = y;
}

StringReader fold_reader = new StringReader(parts[1]);
List<(bool y_axis, int axis_value)> folds = new List<(bool y_axis, int axis_value)>();
while ((line = fold_reader.ReadLine()) != null)
{
    var line_parts = line.Split("=");
    folds.Add((y_axis: line_parts[0].Last() == 'y', axis_value: Int32.Parse(line_parts[1])));
}



for (int i = 0; i < folds.Count; i++)
{
    var fold = folds[i];
    List<(int x, int y)> new_dots;
    if (fold.y_axis)
    {
        new_dots = new List<(int x, int y)>(dots.Where(x => x.y < fold.axis_value).ToList());
        new_dots.AddRange(dots.Where(x => x.y > fold.axis_value).Select(dot => (x: dot.x, y: fold.axis_value - Math.Abs(dot.y - fold.axis_value))).ToList());

        if (i == 0) Console.WriteLine("Stage 1: {0}", new_dots.Distinct().Count());
        max_y = max_y / 2;
    }
    else
    {
        new_dots = new List<(int x, int y)>(dots.Where(x => x.x < fold.axis_value).ToList());
        new_dots.AddRange(dots.Where(x => x.x > fold.axis_value).Select(dot => (x: fold.axis_value - Math.Abs(dot.x - fold.axis_value), y: dot.y)).ToList());

        if (i == 0) Console.WriteLine("Stage 1: {0}", new_dots.Distinct().Count());

        max_x = max_x / 2;
    }
    dots = new_dots.Distinct().ToList();
}

Console.WriteLine("Stage 2: ");
output(dots, max_x, max_y);

void output(List<(int x, int y)> dots, int max_x, int max_y)
{
    for (int y = 0; y <= max_y; y++)
    {
        for (int x = 0; x <= max_x; x++)
        {
            Console.Write("{0}", dots.Any(dot => dot.x == x && dot.y == y) ? "#" : ".");
        }
        Console.Write("\n");
    }
}
