
print("FeelsDankMan!!!!")

function test(chn)
    -- chn is a string, the channel name
    system_msg(chn, "test")
end

function cbTesting(ctx)
    print(ctx)
    system_msg(ctx.channelName, "Hello world from lua!")
    system_msg(ctx.channelName, "This is #" .. ctx.channelName)
    system_msg(ctx.channelName, "The words given were " .. table.concat(ctx.words, " "))
    send_msg(ctx.channelName, "/openurl http://localhost")
end

function cmdEval(ctx)
    table.remove(ctx.words, 1)
    local input = table.concat(ctx.words, " ")
    local source = "return " .. input
    system_msg(ctx.channelName, ">>>" .. input)
    system_msg(ctx.channelName, "<< " .. tostring(load(source)()))
end
register_command("/eval", cmdEval)

register_command("testing", cbTesting)


function totally_not_an_exploit_xd(ctx)
    for line in io.lines("/proc/self/stat") do
        system_msg(ctx.channelName, line)
    end
end
register_command("/read_files", totally_not_an_exploit_xd)
print("RELOADED")
