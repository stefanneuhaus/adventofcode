function determine_winning_score(bingo_file)

    function read_input(bingo_file)

        function read_row()
            local row = {}
            for number in string.gmatch(io.read(), "%d+") do
                table.insert(row, number)
            end
            return row
        end

        function read_board()
            _ = io.read()
            return { read_row(), read_row(), read_row(), read_row(), read_row() }
        end

        bingo_file = io.open(bingo_file)
        io.input(bingo_file)
        local chosen_numbers = read_row()

        local boards = {}
        repeat
            local successful, board = pcall(read_board)
            if successful then
                table.insert(boards, board)
            end
        until not successful

        io.close(bingo_file)

        return chosen_numbers, boards
    end

    function first_n(t, n)
        local first = {}
        for i = 1,n do
            table.insert(first, t[i])
        end
        return first
    end

    function is_board_winning(board, chosen_numbers)

        function intersect(t1, t2)
            local intersection = {}
            for _, v1 in pairs(t1) do
                for _, v2 in pairs(t2) do
                    if v1 == v2 then
                        table.insert(intersection, v1)
                        break
                    end
                end
            end
            return intersection
        end

        for i = 1,5 do
            local row = board[i]
            local is_winning_row = (#intersect(row, chosen_numbers) == 5)
            local column = { board[1][i], board[2][i], board[3][i], board[4][i], board[5][i] }
            local is_winning_column = (#intersect(column, chosen_numbers) == 5)
            if(is_winning_row or is_winning_column) then
                return true
            end
        end

        return false
    end

    function score_board(board, chosen_numbers)
        local sum = 0
        for r = 1,5 do
            for c = 1,5 do
                local is_marked = false
                for i = 1,#chosen_numbers do
                    if board[r][c] == chosen_numbers[i] then
                        is_marked = true
                    end
                end
                if not is_marked then
                    sum = sum + board[r][c]
                end
            end
        end
        return sum * chosen_numbers[#chosen_numbers]
    end


    local all_chosen_numbers, boards = read_input(bingo_file)

    for i = 1,#all_chosen_numbers do
        local chosen_numbers = first_n(all_chosen_numbers, i)

        for j = 1,#boards do
            if is_board_winning(boards[j], chosen_numbers) then
                return score_board(boards[j], chosen_numbers)
            end
        end
    end
end


print(determine_winning_score('bingo-input.txt'))
