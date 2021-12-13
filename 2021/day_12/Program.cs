Dictionary<string, List<string>> edges = new Dictionary<string, List<string>>();
foreach (var line in File.ReadLines(@"input"))
{
    var parts = line.Split('-');
    if (edges.ContainsKey(parts[0]))
    {
        edges[parts[0]].Add(parts[1]);
    }
    else
    {
        edges.Add(parts[0], new List<string> { parts[1] });
    }

    if (edges.ContainsKey(parts[1]))
    {
        edges[parts[1]].Add(parts[0]);
    }
    else
    {
        edges.Add(parts[1], new List<string> { parts[0] });
    }
}

Queue<(string current, List<string> exclusion_list, List<string> visited)> queue = new Queue<(string, List<string>, List<string>)>();
queue.Enqueue(("start", new List<string> { }, new List<string> { }));

int pathCount = 0;
while (queue.Any())
{
    var element = queue.Dequeue();
    element.visited.Add(element.current);

    if (Char.IsLower(element.current[0]))
    {
        element.exclusion_list.Add(element.current);
    }
    if (element.current == "end")
    {
        // Console.WriteLine(String.Join(",", element.visited));
        pathCount++;
    }
    else
    {
        foreach (string neighbor in edges[element.current])
        {
            if (!element.exclusion_list.Contains(neighbor))
            {
                queue.Enqueue((neighbor, new List<string>(element.exclusion_list), new List<string>(element.visited)));
            }
        }
    }
}

Console.WriteLine("Stage 1: {0}", pathCount);


Queue<(string current, List<string> exclusion_list, List<string> exclusion_list_2, List<string> visited) > queue2 = new Queue<(string, List<string>, List<string>, List<string>)>();
queue2.Enqueue(("start", new List<string> { }, new List<string> { }, new List<string> { }));

int pathCount2 = 0;
while (queue2.Any())
{
    var element = queue2.Dequeue();
    element.visited.Add(element.current);
    if (Char.IsLower(element.current[0]))
    {
        if (element.exclusion_list.Contains(element.current))
        {
            if (element.exclusion_list_2.Count == 0) element.exclusion_list_2.Add(element.current);
        }
        else {
            element.exclusion_list.Add(element.current);
        }
    }
    if (element.current == "end")
    {
// Console.WriteLine(String.Join(",", element.visited));
        pathCount2++;
    }
    else
    {
        foreach (string neighbor in edges[element.current])
        {
            if (
                neighbor != "start" && 
                    (
                        (element.exclusion_list.Contains(neighbor) && element.exclusion_list_2.Count == 0)
                        || !element.exclusion_list.Contains(neighbor)
                    )
                )
            {
                queue2.Enqueue((neighbor, new List<string>(element.exclusion_list), new List<string>(element.exclusion_list_2), new List<string>(element.visited)));
            }
        }
    }
}

Console.WriteLine("Stage 2: {0}", pathCount2);