local Client, Message, Arguments = ...

Message.channel:send {
    content = "since nordic asked:\n\nvalid prefixes: p, pies, :pie:, <@1225191085202997343>\ncommands: birthdays, birthdayset, pfp, lokloy, nordic, auroranow, auroraforecast, aurora, ping\nADYHB commands: layout, sign, ping, floor, nightmare",
    reference = {
        message = Message,
        mention = false
    }
}