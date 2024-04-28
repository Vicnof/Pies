local Client, Message, Arguments = ...

local UserID = string.match(Message.content, "%d+")

if Message.content:sub(1, 23) == "<@1225191085202997343> " then 
        UserID = Message.content:sub(24):match("%d+")
end

p(UserID)

if not UserID or string.len(UserID) < 17 or string.len(UserID) > 20 then
    Message.channel:send {
        content = "You have to mention somepony!",
        reference = {
            message = Message,
            mention = false
        }
    }
    return
end

local User = Client:getUser(UserID)

if not User then
    Message.channel:send {
        content = "Sorry, something went wrong trying to get their id.",
        reference = {
            message = Message,
            mention = false
        }
    }
    return
end

Message.channel:send {
    content = User:getAvatarURL().."?size=1024",
    reference = {
        message = Message,
        mention = false
    }
}
