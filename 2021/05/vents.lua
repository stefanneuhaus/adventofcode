Point = {}

function Point:new(x, y)
    local o = { ['x'] = tonumber(x), ['y'] = tonumber(y)}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Point:to_string()
    return "(" .. self.x .. "," .. self.y .. ")"
end


VentCoordinates = {}

function VentCoordinates:new(representation,allow_diagonals)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    local _, _, x1, y1, x2, y2 = string.find(representation, "(%d+),(%d+) %-> (%d+),(%d+)")
    o.p1 = Point:new(x1, y1)
    o.p2 = Point:new(x2, y2)
    return (allow_diagonals or (x1 == x2) or (y1 == y2)) and o or nil
end

function VentCoordinates:all_points()

    function calculate_step(v1, v2)
        if v1 == v2 then
            return 0
        elseif v1 < v2 then
            return 1
        else
            return -1
        end
    end

    local all = {}
    local length = math.max (math.abs(self.p1.x - self.p2.x), math.abs(self.p1.y - self.p2.y))
    local step_x = calculate_step(self.p1.x, self.p2.x)
    local step_y = calculate_step(self.p1.y, self.p2.y)
    for i = 0,length do
        local x = self.p1.x + (i * step_x)
        local y = self.p1.y + (i * step_y)
        table.insert(all, Point:new(x, y))
    end
    return all
end

function VentCoordinates:print()
    print(self.p1:to_string() .. " --> " .. self.p2:to_string())
end


function points_multiply_covered(vents_file, consider_diagonals)
    local vent_coordinates = {}
    for representation in io.lines(vents_file) do
        table.insert(vent_coordinates, VentCoordinates:new(representation, consider_diagonals))
    end

    local points_with_coverage = {}
    setmetatable(points_with_coverage, { __index = function () return 0 end })
    for _,v in pairs(vent_coordinates) do
        for _,p in pairs(v:all_points()) do
            local key = p:to_string()
            points_with_coverage[key] = points_with_coverage[key] + 1
        end
    end

    local result = 0
    for _,coverage in pairs(points_with_coverage) do
        if coverage > 1 then
            result = result + 1
        end
    end
    return result
end


print(points_multiply_covered('hydrothermal-vents.txt', false))
print(points_multiply_covered('hydrothermal-vents.txt', true))
