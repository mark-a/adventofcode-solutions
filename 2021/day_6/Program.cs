// SeeList<char[]> numbers = new List<char[]>(); 


List<int> fishes = File.ReadLines(@"input").First().Split(',').Select(x => Int32.Parse(x)).ToList();

for (int i = 0; i < 80; i++)
{
    List<int> adds = new List<int>();   
    for (int ii = 0; ii < fishes.Count; ii++)
    {
        int f = fishes[ii];
        if (f > 0)
        {
            fishes[ii] = --f;
        }
        else
        {
            fishes[ii] = 6;
            adds.Add(8);
        }
    }
    fishes.AddRange(adds);
}

System.Console.WriteLine("Stage 1: {0} fishes after 80 days", fishes.Count());

// ##############################################################


Dictionary<int, ulong> group_fishes = File.ReadLines(@"input")
    .First()
    .Split(',')
    .Select(x => Int32.Parse(x)).ToList()
    .GroupBy(x => x)
    .ToDictionary(x => x.Key, x => (ulong) x.Count());


for (int i = 0; i < 256; i++)
{

    Dictionary<int, ulong> new_groups = new Dictionary<int, ulong>();

    new_groups.Add(0, group_fishes.GetValueOrDefault(1, (ulong) 0));
    new_groups.Add(1, group_fishes.GetValueOrDefault(2, (ulong)0));
    new_groups.Add(2, group_fishes.GetValueOrDefault(3, (ulong)0));
    new_groups.Add(3, group_fishes.GetValueOrDefault(4, (ulong)0));
    new_groups.Add(4, group_fishes.GetValueOrDefault(5, (ulong)0));
    new_groups.Add(5, group_fishes.GetValueOrDefault(6, (ulong)0));
    new_groups.Add(6, group_fishes.GetValueOrDefault(7, (ulong)0));
    new_groups.Add(7, group_fishes.GetValueOrDefault(8, (ulong)0));

    if (group_fishes.ContainsKey(0))
    {
        new_groups.Add(8, group_fishes.GetValueOrDefault(0, (ulong)0));
        new_groups[6] += group_fishes[0];
    }

    group_fishes = new_groups;
}

foreach (var group in group_fishes) {
    System.Console.WriteLine("{0} : {1}", group.Key, group.Value);
}

System.Console.WriteLine("Stage 2: {0} fishes after 256 days", group_fishes.Sum(x => (long) x.Value));

// Suspend the screen.  
System.Console.ReadLine();