int[][] heightmap = File.ReadLines(@"input")
    .Select(line => line.Select(x => Int32.Parse(x.ToString()))
                    .ToArray())
    .ToArray();

List<(int, int, int)> localMinima = new List<(int, int, int)>();

foreach (var (row, row_index) in heightmap.Select((item, index) => (item, index)))
{
    foreach (var (value, column_index) in row.Select((item, index) => (item, index)))
    {
        bool islocalMinima = true;
        if (row_index > 0)
        {
            islocalMinima = islocalMinima && heightmap[row_index - 1][column_index] > value;
        }
        if (row_index < heightmap.Length - 1)
        {
            islocalMinima = islocalMinima && heightmap[row_index + 1][column_index] > value;
        }
        if (column_index > 0)
        {
            islocalMinima = islocalMinima && heightmap[row_index][column_index - 1] > value;
        }
        if (column_index < row.Length - 1)
        {
            islocalMinima = islocalMinima && heightmap[row_index][column_index + 1] > value;
        }
        if (islocalMinima)
        {
            localMinima.Add((value, row_index, column_index));
        }
    }
}

Console.WriteLine("Stage 1: {0}", localMinima.Select(x => x.Item1 + 1).Sum());


var sizes = new List<long>();
foreach (var (_value, row, column) in localMinima)
{
    var area = 0;
    var seen = new HashSet<(int row, int column)>();

    IEnumerable<(int row, int column)> traverse((int row, int column) p)
    {
        var (row, column) = p;

        if (heightmap[row][column] == 9) yield break;

        if (seen.Contains((row, column))) yield break;
        seen.Add((row, column));

        area++;

        if (column > 0)
            yield return (row, column - 1);
        if (column < heightmap[row].Length - 1)
            yield return (row, column + 1);
        if (row > 0)
            yield return (row - 1, column);
        if (row < heightmap.Length - 1)
            yield return (row + 1, column);
    }

    IEnumerable<T> BreadthFirst<T>(T root, Func<T, IEnumerable<T>> child)
    {
        return step();
        IEnumerable<T> step()
        {
            Queue<T> queue = new Queue<T>();
            queue.Enqueue(root);
            while (queue.Count != 0)
            {
                T current = queue.Dequeue();
                yield return current;
                foreach (T item in child(current))
                {
                    queue.Enqueue(item);
                }
            }
        }
    }

    foreach (var element in BreadthFirst((row, column), traverse)) ;

    sizes.Add(area);
}

Console.WriteLine("Stage 2: {0}", sizes
           .OrderByDescending(x => x)
           .Take(3)
           .Aggregate(1L, (a, b) => a * b)
);