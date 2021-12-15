var rows = File.ReadAllLines("input");

int[][] riskMap = new int[rows.Length][];
for (int i = 0; i < rows.Length; i++)
{
    riskMap[i] = new int[rows[i].Length];
    for (int j = 0; j < rows[i].Length; j++)
    {
        riskMap[i][j] = (Int32.Parse(rows[i][j].ToString()));
    }
}

var queue = new PriorityQueue<(int y, int x), int>();
var total = new Dictionary<(int, int), int>();

total[(0, 0)] = 0;
queue.Enqueue((y: 0, x: 0), 0);

while (queue.Count > 0)
{
    var current = queue.Dequeue();

    foreach (var neighbor in new List<(int x, int y)> { (0, 1), (1, 0), (0, -1), (-1, 0) })
    {
        var x = current.x + neighbor.x;
        var y = current.y + neighbor.y;
        if (!total.ContainsKey((y, x)) && x >= 0 && y >= 0 && y < riskMap.Length && x < riskMap[0].Length)
        {
            var new_risk = total[(current.y, current.x)] + riskMap[y][x];
            total[(y, x)] = new_risk;
            queue.Enqueue((y, x), new_risk);
        }
    }

}

Console.WriteLine("Stage 1: {0}", total[(riskMap.Length - 1, riskMap[0].Length - 1)]);



var queue2 = new PriorityQueue<(int y, int x), int>();
var total2 = new Dictionary<(int, int), int>();

total2[(0, 0)] = 0;
queue2.Enqueue((y: 0, x: 0), 0);

while (queue2.Count > 0)
{
    var current = queue2.Dequeue();

    foreach (var neighbor in new List<(int x, int y)> { (0, 1), (1, 0), (0, -1), (-1, 0) })
    {
        var x = current.x + neighbor.x;
        var y = current.y + neighbor.y;
        if (!total2.ContainsKey((y, x)) && x >= 0 && y >= 0 && y < (riskMap.Length * 5) && x < (riskMap[0].Length * 5))
        {
            var new_risk = total2[(current.y, current.x)] + scaledRisk(y, x, riskMap);
            total2[(y, x)] = new_risk;
            queue2.Enqueue((y, x), new_risk);
        }
    }

}


Console.WriteLine("Stage 2: {0}", total2[((riskMap.Length * 5) - 1, (riskMap[0].Length * 5) - 1)]);

int scaledRisk(int y, int x, int[][] original)
{
    int risk = original[y % original[0].Length][x % original.Length];
    int addition = x / original.Length + y / original[0].Length;
    risk += addition;
    if (risk > 9) { risk -= 9; }
    return risk;
}