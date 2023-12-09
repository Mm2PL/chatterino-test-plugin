print("FeelsDankMan!!!!")

function cmdEval(ctx)
    table.remove(ctx.words, 1)
    local input = table.concat(ctx.words, " ")
    local source = "return " .. input
    c2.system_msg(ctx.channel_name, ">>>" .. input)
    local f, err = load(source)
    if f == nil then
        c2.system_msg(ctx.channel_name "!<" .. tostring(err))
    else
        c2.system_msg(ctx.channel_name, "<< " .. tostring(f()))
    end
end

function startswith(str, prefix)
    return string.sub(str, 1, prefix:len()) == prefix
end

function cmdFoo(ctx)
    table.remove(ctx.words, 1)
    local sub = ctx.words[1]
    if sub == "barbazA" then
        c2.system_msg(ctx.channel_name, "You used the first subcommand")
    elseif sub == "bazbarB" then
        c2.system_msg(ctx.channel_name, "You used the second subcommand")
    else
        c2.system_msg(ctx.channel_name, "You used neither subcommand. Try barbazA and bazbarB")
    end
end

function onCompletion(query, full_text_content, cursor_position, is_first_word)
    local list = {
        hide_others = false,
        values = {},
    }
    c2.system_msg("pajlada", "Completing! " .. query .. "; " .. full_text_content .. "!")
    if startswith(full_text_content, "/foo") then
        -- note this doesn't account for completion being anything after the 2nd argument
        list.values = {"barbazA", "bazbarB"}
        list.hide_others = true
    end
    return list
end

c2.register_command("/eval", cmdEval)
c2.register_command("/foo", cmdFoo)
c2.register_callback(c2.EventType.CompletionRequested, onCompletion)
