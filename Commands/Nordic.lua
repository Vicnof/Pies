local Client, Message, Arguments = ...

local SemesterEnd = os.time {
    year = 2024,
    month = 9,
    day = 15,
    hour = 4,
}

local Days = math.ceil((SemesterEnd - os.time()) / 86400)

if Days < 0 then
    Message.channel:send {
        content = "Nordic got his account back!",
        reference = {
            message = Message,
            mention = false
        }
    }
    return
end

if Days == 1 then
    Message.channel:send {
        content = "The final day.",
        reference = {
            message = Message,
            mention = false
        }
    }
    return
end

Message.channel:send {
    content = Days.." days until Nordic gets his account back.",
    reference = {
        message = Message,
        mention = false
    }
}
