int[] positions = File.ReadLines("input")
    .First()
    .Split(',')
    .Select(x => Int32.Parse(x))
    .ToArray();

int[] deltas = new int[positions.Length];
for (int i = 0; i < deltas.Length; i++)
{
    int deltaSum = 0;
    for (int ii = 0; ii < positions.Length; ii++)
    {
        deltaSum += Math.Abs(positions[ii] - i);
    }

    deltas[i] = deltaSum;
}

Console.WriteLine("Stage 1: {0}",deltas.Min());



int[] expDeltas = new int[positions.Length];
for (int i = 0; i < expDeltas.Length; i++)
{
    int deltaSum = 0;
    for (int ii = 0; ii < positions.Length; ii++)
    {
        int diff = Math.Abs(positions[ii] - i);
        deltaSum +=   (1 + diff ) * diff / 2;
    }

    expDeltas[i] = deltaSum;
}

Console.WriteLine("Stage 2: {0}", expDeltas.Min());