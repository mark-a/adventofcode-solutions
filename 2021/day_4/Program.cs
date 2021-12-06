
string[] input = File.ReadAllLines(@"input");
int[] inputs = File.ReadLines(@"input").First().Split(',').Select(x => Int32.Parse(x)).ToArray();

List<Field[][]> final = ParseBoards(input);
List<Field[][]> final2 = final;
Console.WriteLine($"Stage 1: {FirstWinner(final, inputs)}");

Console.WriteLine($"Stage 2: {LastWinner(final2, inputs)}");


static object FirstWinner(List<Field[][]> boadrs, int[] combinations)
{
    int result = 0;
    for (int number = 0; number < combinations.Length; number++)
    {
        int boardNumber = 0;
        foreach (Field[][] board in boadrs)
        {
            for (int row = 0; row < board.Length; row++)
            {
                for (int column = 0; column < 5; column++)
                {
                    if (!board[row][column].Called && board[row][column].Value == combinations[number])
                    {
                        board[row][column].Called = true;
                    }
                }
            }

            boardNumber++;
        }

        if (combinations[number] > 5)
        {
            int others = CheckIfAnyWin(boadrs);
            if (others != -1)
            {
                result = others * combinations[number];
                break;
            }
        }
    }

    return result;
}

static object LastWinner(List<Field[][]> boards, int[] combinations)
{
    int largestWinRound = 0;
    int result = 0;
    foreach (Field[][] board in boards)
    {
        int boardWinRound = 0;
        List<Field[][]> ad = new List<Field[][]>() { board };
        for (int number = 0; number < combinations.Length; number++)
        {
            for (int row = 0; row < board.Length; row++)
            {
                for (int column = 0; column < 5; column++)
                {
                    if (!board[row][column].Called && board[row][column].Value == combinations[number])
                    {
                        board[row][column].Called = true;
                    }
                }
            }

            if (combinations[number] > 5)
            {
                int others = CheckIfAnyWin(ad);
                if (others != -1)
                {
                    if (boardWinRound > largestWinRound)
                    {
                        largestWinRound = boardWinRound;

                        boardWinRound = 0;
                        result = others * combinations[number];
                    }

                    break;
                }
            }

            boardWinRound++;
        }
    }

    return result;
}


static List<Field[][]> ParseBoards(string[] input)
{
    List<List<Field[]>> allBoards = new List<List<Field[]>>();
    List<Field[]>? current = null;
    for (int i = 1; i < input.Length; i++)
    {
        if (input[i] == "")
        {
            current = new List<Field[]>();
            allBoards.Add(current);
            continue;
        }
        var row = input[i].Split(new char[0], StringSplitOptions.RemoveEmptyEntries).Select(x => Int32.Parse(x)).ToList();

        Field[] field_row = row.Select(x => new Field(x) ).ToArray();
        if(current != null) current.Add(field_row);
    }

    if (current != null) allBoards.Add(current);
    allBoards.RemoveAt(0);

    List<Field[][]> boards = new List<Field[][]>();
    foreach (var board in allBoards)
    {
        boards.Add(board.ToArray());
    }

    return boards;
}

static int CheckIfAnyWin(List<Field[][]> final)
{
    int found = -1;
    int result = -1;
    for (int boardNumber = 0; boardNumber < final.Count; boardNumber++)
    {
        var current = final[boardNumber];
        for (int index = 0; index < current.Length; index++)
        {
            if (current[index].All(x => x.Called) || current.Select(x => x[index]).All(x => x.Called))
            {
                found = boardNumber;
            }
        }
    }

    if (found != -1)
    {
        var otherNumbers = final[found].SelectMany(x => x).Where(x => !x.Called).ToArray();
        result = (Array.ConvertAll(otherNumbers, z => z.Value)).Sum();
    }

    return result;
}

class Field
{
    public int Value;
    public bool Called;

    public Field(int value)
    {
        Value = value;
        Called = false;
    }
}