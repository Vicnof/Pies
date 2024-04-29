local Client, Message, Arguments = ...

Message.channel:send {
    content = "since nordic asked:\n\nvalid prefixes: p, pies\ncommands: birthdays, pfp, lokloy, layout, sign, ping, floor",
    reference = {
        message = Message,
        mention = false
    }
}