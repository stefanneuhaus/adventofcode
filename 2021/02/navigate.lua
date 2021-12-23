depth = 0
horizontal = 0

run = {
    ['forward'] = function (value) horizontal = horizontal + value end,
    ['down']    = function (value) depth = depth + value end,
    ['up']      = function (value) depth = depth - value end,
}

for command in io.lines 'course.txt' do
    _, _, direction, value = string.find(command, "(%a+) (%d+)")
    run[direction] (value)
end

print("depth:      " .. depth)
print("horizontal: " .. horizontal)
print("--> " .. (depth * horizontal))
