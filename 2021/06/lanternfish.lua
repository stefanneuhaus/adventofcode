function number_of_lanternfish(lanternfish_ages_file, x)

    function number_of_fish_per_age(lanternfish_ages_file)
        local file_handle = io.open(lanternfish_ages_file)
        io.input(file_handle)
        local ages = io.read()
        io.close()

        local number_of_fish_per_age = {}
        setmetatable(number_of_fish_per_age, { __index = function () return 0 end })
        for age in string.gmatch(ages, "(%d+)") do
            local key = tonumber(age)
            number_of_fish_per_age[key] = number_of_fish_per_age[key] + 1
        end
        return number_of_fish_per_age
    end

    function ages_one_day_later(current_age)
        return (current_age) > 0 and { current_age - 1 } or { 6, 8 }
    end

    function ages_and_counts_after_x_days(current, x)
        if x == 0 then
            return current
        end
        local next = { }
        setmetatable(next, { __index = function () return 0 end })
        for age,count in pairs(current) do
            local ages_next = ages_one_day_later(age)
            for _,new_age in pairs(ages_next) do
                next[new_age] = next[new_age] + count
            end
        end
        return ages_and_counts_after_x_days(next, x - 1)
    end

    local initial_ages_and_counts = number_of_fish_per_age(lanternfish_ages_file)
    local final_ages_and_counts = ages_and_counts_after_x_days(initial_ages_and_counts, x)
    local overall_count = 0
    for _,count in pairs(final_ages_and_counts) do
        overall_count = overall_count + count
    end
    return overall_count
end


print(number_of_lanternfish('lanternfish-ages.txt', 80))
print(number_of_lanternfish('lanternfish-ages.txt', 256))
