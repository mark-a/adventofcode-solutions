row = 1
column = 1
jumper = 0

code = 20151125

grid = {
 "1:1" => code
}

while row <= 3010 || column <= 3019 do
    if row == 1
        jumper += 1
        row += jumper
        column = 1
    else
        row -= 1
        column += 1
    end
    code = (code * 252533) % 33554393
    grid[column.to_s +  ":" + row.to_s] = code
end

puts grid["3019:3010"]