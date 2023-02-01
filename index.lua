
print("FeelsDankMan!!!!")

function test(chn)
    -- chn is a string, the channel name
    c2.system_msg(chn, "test")
end

function cbTesting(ctx)
    print(ctx)
    c2.system_msg(ctx.channelName, "Hello world from lua!")
    c2.system_msg(ctx.channelName, "This is #" .. ctx.channelName)
    c2.system_msg(ctx.channelName, "The words given were " .. table.concat(ctx.words, " "))
    c2.send_msg(ctx.channelName, "/openurl http://localhost")
end

function cmdEval(ctx)
    table.remove(ctx.words, 1)
    local input = table.concat(ctx.words, " ")
    local source = "return " .. input
    c2.system_msg(ctx.channelName, ">>>" .. input)
    c2.system_msg(ctx.channelName, "<< " .. tostring(load(source)()))
end
c2.register_command("/eval", cmdEval)

c2.register_command("testing", cbTesting)


function totally_not_an_exploit_xd(ctx)
    for line in io.lines("/proc/self/stat") do
        c2.system_msg(ctx.channelName, line)
    end
end
c2.register_command("/read_files", totally_not_an_exploit_xd)
print("RELOADED")
