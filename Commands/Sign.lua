local Client, Message, Arguments = ...

local Sign = Message.content:sub(Message.content:find(Arguments[1]) + 5)
local Match = Arguments[#Arguments]

Message.channel:send {
    content = "# "..string.sub(Sign, Match, Match),
    reference = {
        message = Message,
        mention = false
    }
}
