int last = 0;
int increment_count = 0;

int[] last_three = { 0, 0, 0 };
int last_three_sum = 0;
int sum_increment_count = 0;

int counter = 0;
// Read the file and display it line by line.  
foreach (string line in System.IO.File.ReadLines(@"input"))
{
    bool success = Int32.TryParse(line, out int x);

    if (success)
    {
   
        if (x > last && last != 0) {
            increment_count++;
        }

        last_three[counter % 3] = x;

        if (last_three.All(i => i > 0) ){
            int temp_sum = last_three.Sum();

            if (temp_sum > last_three_sum && last_three_sum != 0) {
                sum_increment_count++;
            }

            last_three_sum = temp_sum;
        }

        last = x;

        counter++;
    }
    else
    {
        Console.WriteLine("Input string is invalid.");
    }
}

System.Console.WriteLine("There were {0} increments.", increment_count);
System.Console.WriteLine("There were {0} sum increments.", sum_increment_count);
// Suspend the screen.  
System.Console.ReadLine();
