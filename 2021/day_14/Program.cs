var parts = File.ReadAllText("input").Split("\n\n");

var polymer = parts[0];

var reactionDict = ReadLines(new StringReader(parts[1]))
    .Select(line => line.Split(" -> "))
    .Select(parts => (molecule: parts[0], element: parts[1]))
    .ToDictionary(p => p.molecule, p => p.element);


Console.WriteLine($"Stage 1: {loopAndCount(polymer, reactionDict, 10)}");

Console.WriteLine($"Stage 2: {loopAndCount(polymer, reactionDict, 40)}");

IEnumerable<string> ReadLines(StringReader reader)
{
    string line;
    while ((line = reader.ReadLine()) != null)
    {
        yield return line;
    }
}

long loopAndCount(string polymer, Dictionary<string, string> reactionDict, int cycles)
{
    var moleculeCount = new Dictionary<string, long>();
    foreach (var i in Enumerable.Range(0, polymer.Length - 1))
    {
        var molecule = polymer.Substring(i, 2);
        moleculeCount[molecule] = moleculeCount.GetValueOrDefault(molecule) + 1;
    }

    for (var i = 0; i < cycles; i++)
    {
        var updated = new Dictionary<string, long>();
        foreach (var (molecule, count) in moleculeCount)
        {
            var (a, n, b) = (molecule[0], reactionDict[molecule], molecule[1]);
            updated[$"{a}{n}"] = updated.GetValueOrDefault($"{a}{n}") + count;
            updated[$"{n}{b}"] = updated.GetValueOrDefault($"{n}{b}") + count;
        }
        moleculeCount = updated;
    }

    var elementCounts = new Dictionary<char, long>();
    foreach (var (molecule, count) in moleculeCount)
    {
        var a = molecule[0];
        elementCounts[a] = elementCounts.GetValueOrDefault(a) + count;
    }

    elementCounts[polymer.Last()]++;

    return elementCounts.Values.Max() - elementCounts.Values.Min();
}



