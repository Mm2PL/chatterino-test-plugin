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

c2.register_command("/eval", cmdEval)
