
List<(Command, int)> commands = new List<(Command, int)>();

foreach (string line in File.ReadLines(@"input"))
{
    string[] subs = line.Split(' ');
    Command cmd = subs[0] switch
    {
    "forward" => Command.Forward,
    "down" => Command.Down,
    "up" => Command.Up,
    _ => throw new InvalidDataException(line)
    };

    int number = int.Parse(subs[1]);
    commands.Add((cmd, number));
}


int down_sum = commands.FindAll(command => command.Item1 == Command.Down).Sum(command => command.Item2); 
int up_sum = commands.FindAll(command => command.Item1 == Command.Up).Sum(command => command.Item2); 
int forward_sum = commands.FindAll(command => command.Item1 == Command.Forward).Sum(command => command.Item2); 

System.Console.WriteLine("Stage 1: {0} deep  {1} forward , product: {2}", down_sum - up_sum, forward_sum, (down_sum - up_sum) * forward_sum);

int forward = 0;
int deep = 0;
int aim = 0;

foreach ((Command,int) command in commands)
{
    switch (command.Item1) {
        case Command.Forward: 
            forward += command.Item2;
            deep += aim * command.Item2; 
            break;
        case Command.Up:
                aim -= command.Item2;
            break;
        case Command.Down:
            aim += command.Item2; 
            break;
    }
}

System.Console.WriteLine("Stage 2: {0} deep  {1} forward , product: {2}", deep, forward,deep * forward);

// Suspend the screen.  
System.Console.ReadLine();

public enum Command
{
    Forward,
    Down,
    Up
}
