print("FeelsDankMan!!!!")

function cmdEval(ctx)
    table.remove(ctx.words, 1)
    local input = table.concat(ctx.words, " ")
    local source = ("local args = {...}\n"
        .. "local ctx = args[1]\n"
        .. "return " .. input)
    ctx.channel:add_system_message(">>>" .. input)
    local f, err = load(source)
    if f == nil then
        ctx.channel:add_system_message("!<" .. tostring(err))
    else
        ctx.channel:add_system_message("<< " .. tostring(f(ctx)))
    end
end

function startswith(str, prefix)
    return string.sub(str, 1, prefix:len()) == prefix
end

function cmdFoo(ctx)
    table.remove(ctx.words, 1)
    local sub = ctx.words[1]
    if sub == "barbazA" then
        ctx.channel:add_system_message("You used the first subcommand")
    elseif sub == "bazbarB" then
        ctx.channel:add_system_message("You used the second subcommand")
    else
        ctx.channel:add_system_message("You used neither subcommand. Try barbazA and bazbarB")
    end
end

function cmd_filesystem(ctx)
    table.remove(ctx.words, 1)
    local filename = "test"
    local TEST_STRING = 'This is a test!\nHere is second line\n'

    ctx.channel:add_system_message("Opening file \"" .. filename .. "\" for writing.")
    local file = io.open(filename, 'w')
    ctx.channel:add_system_message("Writing " .. tostring(#TEST_STRING) .. " bytes.")
    print('Write', txt)
    file:write(TEST_STRING)
    file:close()

    ctx.channel:add_system_message("Opening file \"" .. filename .. "\" for reading.")
    file = io.open(filename)
    txt = file:read('a')
    ctx.channel:add_system_message("Read " .. tostring(#txt) .. " bytes.")
    file:close()
    print(txt)

    ctx.channel:add_system_message("Opening file \"" .. filename .. "\" for reading using alternate API.")
    io.input(filename)

    local i = 1
    for l in io.lines() do
        print('Line ' .. tostring(i) .. ': ' .. l)
        i = i + 1
    end
end

function onCompletion(query, full_text_content, cursor_position, is_first_word)
    local list = {
        hide_others = false,
        values = {},
    }
    c2.Channel.by_name("pajlada", c2.Platform.Twitch):add_system_message("Completing! " .. query .. "; " .. full_text_content .. "!")
    if startswith(full_text_content, "/foo ") then
        -- note this doesn't account for completion being anything after the 2nd argument
        list.values = {"barbazA", "bazbarB"}
        list.hide_others = true
    end
    return list
end

c2.register_command("/eval", cmdEval)
c2.register_command("/foo", cmdFoo)
c2.register_command("/test-fs", cmd_filesystem)
c2.register_callback(c2.EventType.CompletionRequested, onCompletion)
