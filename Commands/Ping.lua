local Client, Message, Arguments = ...

local Pong = Message.channel:send {
    content = "Pong!",
    reference = {
        message = Message,
        mention = false
    }
}

local TotalPing = math.ceil((Pong.createdAt - Message.createdAt) * 1000)

Pong:update {
    content = "Pong!\n2-way ping: "..TotalPing.."ms"
}
