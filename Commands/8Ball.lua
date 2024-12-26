local Command, Message, Arguments, Database, Timer = ...

local Answers = {
	"Absolutely not.",
	"Of course not."
}

Message.channel:send("Thinking...")

Message.channel:broadcastTyping()

Timer.sleep(3000)

local Original = ">"

for Index, Argument in pairs(Arguments) do
	if Index > 1 then
	Original = Original.." "..Argument
	end
end

Original = "*"..Original.."*"

Message.channel:send {
	content = Original.."\n\n🎱 "..Answers[math.random(1, #Answers)],
	reference = {
		message = Message,
		mention = true
	}
}
