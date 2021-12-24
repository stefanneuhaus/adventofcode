function gamma_and_epsilon_rate(diagnostic_report_file)

    local counts = {}
    setmetatable(counts, {__index = function () return 0 end})

    local number_of_bits = 0

    function lookup_index(index, bit) return index .. '-' .. bit end

    -- read and process diagnostic report file for determining counts
    for sample in io.lines(diagnostic_report_file) do
        for index = 1, #sample do
            local bit = string.sub(sample, index, index)
            local lookup_index = lookup_index(index, bit)
            counts[lookup_index] = counts[lookup_index] + 1
            number_of_bits = math.max(number_of_bits, index)
        end
    end

    -- determine gamma and epsilon rate
    local gamma_rate, epsilon_rate = 0, 0;

    for i = 1,number_of_bits do
        local summand = 1 << (number_of_bits - i)
        local is_zero_most_common = counts[lookup_index(i, '0')] > counts[lookup_index(i, '1')]
        local addend_gamma_rate = is_zero_most_common and 0 or summand
        local addend_epsilon_rate = is_zero_most_common and summand or 0
        gamma_rate = gamma_rate + addend_gamma_rate
        epsilon_rate = epsilon_rate + addend_epsilon_rate
    end

    return gamma_rate, epsilon_rate
end


function oxygengenerator_and_co2scrubber_rating(diagnostic_report_file)

    function split(candidates, offset)
        local splits = { ['0'] = {}, ['1'] = {} }
        for _, sample in pairs(candidates) do
            local bit = string.sub(sample, offset, offset)
            table.insert(splits[bit], sample)
        end

        if(#splits['0'] > #splits['1']) then
            return splits['0'], splits['1']
        else
            return splits['1'], splits['0']
        end
    end

    -- read and process diagnostic report file
    local oxygen_candidates, co2_candidates = {}, {}
    for sample in io.lines(diagnostic_report_file) do
        table.insert(oxygen_candidates, sample)
        table.insert(co2_candidates, sample)
    end

    -- cut down candidates ...
    local i = 1
    while #oxygen_candidates > 1 do
        oxygen_candidates, _ = split(oxygen_candidates, i)
        i = i + 1
    end
    local i = 1
    while #co2_candidates > 1 do
        _, co2_candidates = split(co2_candidates, i)
        i = i + 1
    end

    -- determine ratings
    local oxygengenerator_rating = tonumber(oxygen_candidates[1], 2);
    local co2scrubber_rating = tonumber(co2_candidates[1], 2);

    return oxygengenerator_rating, co2scrubber_rating
end


gamma_rate, epsilon_rate = gamma_and_epsilon_rate('diagnostic-report.txt')
print(gamma_rate * epsilon_rate)

oxygengenerator_rating, co2scrubber_rating = oxygengenerator_and_co2scrubber_rating('diagnostic-report.txt')
print(oxygengenerator_rating * co2scrubber_rating)
