local Command, Message, Arguments, Database, Timer = ...

local Answers = {
	"It is certain.",
	"It is decidedly so.",
	"Without a doubt.",
	"Yes, definitely.",
	"You may rely on it.",
	"As I see it, yes.",
	"Most likely.",
	"Outlook good.",
	"Yes.",
	"Signs point to... yes.",
	"Reply hazy, try again.",
	"Ask again later.",
	"Better not tell you now.",
	"Cannot predict now.",
	"Concentrate and ask again.",
	"Don't count on it.",
	"My reply is no.",
	"My sources say no.",
	"Outlook not so good.",
	"Very doubtful."
}

Message.channel:send("Thinking...")

Message.channel:broadcastTyping()

Timer.sleep(3000)

Message.channel:send {
	content = "🎱 "..Answers[math.random(1, #Answers)],
	reference = {
		message = Message,
		mention = true
	}
}
