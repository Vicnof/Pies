local Command, Message, Arguments, Database, Timer = ...

if Message.author.id ~= "240291244306071552" then
	return
end

Client:stop()

Timer.sleep(3000)

os.execute("bash Commands/Restart.sh")

process:exit()
