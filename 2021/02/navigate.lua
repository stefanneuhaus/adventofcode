calculation1 = {
    ['depth'] = 0,
    ['horizontal'] = 0
}

calculation2 = {
    ['depth'] = 0,
    ['horizontal'] = 0,
    ['aim'] = 0
}


function forward(value)
    calculation1['horizontal'] = calculation1['horizontal'] + value
    calculation2['horizontal'] = calculation2['horizontal'] + value
    calculation2['depth'] = calculation2['depth'] + (calculation2['aim'] * value)
end

function down(value)
    calculation1['depth'] = calculation1['depth'] + value
    calculation2['aim'] = calculation2['aim'] + value
end

function up(value)
    calculation1['depth'] = calculation1['depth'] - value
    calculation2['aim'] = calculation2['aim'] - value
end


for command in io.lines 'course.txt' do
    _, _, direction, value = string.find(command, "(%a+) (%d+)")
    _G[direction](value)
end


print(calculation1['depth'] * calculation1['horizontal'])
print(calculation2['depth'] * calculation2['horizontal'])
