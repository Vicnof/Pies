local Command, Message, Arguments, Timer = ...

Message.channel:send("Flipping...")

Message.channel:broadcastTyping()

Timer.sleep(3000)

local Result = "",
local RNG = math.random(1, 1000)

if RNG == 1 then
	Result = "It landed on its edge!"
elseif RNG % 2 == 0 then
	Result = "Heads."
else
	Result = "Tails."
end

Message.channel:send {
	content = Result,
	reference = {
		message = Message,
		mention = true
	}
}
