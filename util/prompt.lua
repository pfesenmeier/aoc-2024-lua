return function(line)
    vim.ui.input({ prompt = line .. "         Continue (y/n)?: " }, function(input)
        if input == 'n' then
            error()
        end
    end)
end
