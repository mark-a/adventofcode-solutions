string[] rows = File.ReadAllLines(@"input").ToArray();

(int value, bool flashed)[,] energyMap = new (int, bool)[10, 10];

for (int i = 0; i < rows.Length; i++)
    for (int j = 0; j < rows[i].Length; j++)
    {
        energyMap[j, i] = (value: Int32.Parse(rows[i][j].ToString()),flashed: false);
    }


IEnumerable<((int x, int y), T)> Flatten<T>(T[,] map)
{
    for (int row = 0; row < map.GetLength(0); row++)
    {
        for (int col = 0; col < map.GetLength(1); col++)
        {
            yield return ((x: row, y: col), map[row, col]);
        }
    }
}

int flashes = 0;
int counter = 0;
while (true)
{
    counter++;
    for (int xx = 0; xx < rows.Length; xx++)
        for (int yy = 0; yy < rows.Length; yy++)
        {
            energyMap[xx, yy].value += 1;
        }

    while (true)
    {
        try
        {
            ((int x, int y) position, (int value, bool flashed) octopus) nextElement = Flatten(energyMap).First(x => (x.Item2.value > 9 && !x.Item2.flashed));
            energyMap[nextElement.Item1.Item1, nextElement.Item1.Item2].Item2 = true;
            flashes++;
            for (int x = nextElement.position.x - 1; x <= nextElement.position.x + 1; x++)
                for (int y = nextElement.position.y - 1; y <= nextElement.position.y + 1; y++)
                {
                    if (x >= 0 && y >= 0 && x < rows.Length && y < rows.Length)
                    {
                        energyMap[x, y].value++;
                    }
                }
        }
        catch (InvalidOperationException)
        {

            break;
        }
    }


    if (Flatten(energyMap).All(x => x.Item2.flashed))
    {
        break;
    }
    for (int x = 0; x < rows.Length; x++)
        for (int y = 0; y < rows.Length; y++)
        {
            if (energyMap[x, y].flashed) energyMap[x, y] = (value: 0, flashed: false);
        }

    if (counter == 100)
    {
        Console.WriteLine("Stage 1: {0}", flashes);
    }
}

Console.WriteLine("Stage 2: {0}", counter);
