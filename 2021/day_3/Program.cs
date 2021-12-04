
int[] one_count = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
int[] zero_count = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

List<char[]> numbers = new List<char[]>(); 

foreach (string line in File.ReadLines(@"input"))
{
    char[] bits = line.ToCharArray();
    numbers.Add(bits);

    for (int i = 0; i < bits.Length; i++)
    {
        if (bits[i] == '1') 
        {
            one_count[i]++;
        }
        else
        {
            zero_count[i]++;
        }
    }
}

string most_string ="", least_string = "";

for (int i = 0; i < one_count.Length; i++)
{
    if (one_count[i] > zero_count[i]) 
    {
        most_string += "1";
        least_string += "0";
    } 
    else 
    {
        most_string += "0";
        least_string += "1";
    }
}



int gamma = Convert.ToInt32(most_string, 2);
int epsilon = Convert.ToInt32(least_string, 2);


System.Console.WriteLine("Stage 1: {0} gamma  {1} epsilon , product: {2}", most_string, least_string, gamma * epsilon);

// ################################################################################################

List<char[]> most_list = numbers;
List<char[]> least_list = numbers;

for (int i = 0; i < 12; i++)
{
    if (most_list.Count > 1)
    {
        var temp_most_count = most_list.GroupBy(t => t[i])
                           .Select(t => new
                           {
                               Category = t.Key,
                               Count = t.Count(),
                           }).ToList();

    var ordered_most = temp_most_count.OrderByDescending(i => i.Count);

    char max = ordered_most.First().Category;

    if (ordered_most.ElementAt(0).Count == ordered_most.ElementAt(1).Count) {
            max = '1';
        }

      most_list = most_list.Where(t => t[i] == max).ToList();
    }

    if (least_list.Count > 1)
    {
        var temp_least_count = least_list.GroupBy(t => t[i])
                       .Select(t => new
                       {
                           Category = t.Key,
                           Count = t.Count(),
                       }).ToList();

        var ordered_least = temp_least_count.OrderBy(i => i.Count);

        char min = ordered_least.First().Category;

        if (ordered_least.ElementAt(0).Count == ordered_least.ElementAt(1).Count)
        {
            min = '0';
        }

        least_list = least_list.Where(t => t[i] == min).ToList();
    }

}

int oxygen = Convert.ToInt32(String.Join("", most_list[0]), 2);
int scrubber = Convert.ToInt32(String.Join("", least_list[0]), 2);


System.Console.WriteLine("Stage 1: {0} oxygen {1} scrubber: rating: {2} ", oxygen, scrubber, oxygen * scrubber);



// Suspend the screen.  
System.Console.ReadLine();