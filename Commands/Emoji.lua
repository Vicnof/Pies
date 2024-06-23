local Command, Message, Arguments, Database, Timer = ...

if Message.mentionedEmojis.first == nil then
	Message.channel:send("No emoji mentioned.")
 	return
end

Message.channel:send(Message.mentionedEmojis.first.url)
