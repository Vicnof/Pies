local Client, Message, Arguments, Database, Timer = ...

if Message.author.id ~= "240291244306071552" then
	return
end

Client:stop()
Timer.sleep(3000) -- Let any database operations finish up
os.execute("bash Commands/Update.sh")
process:exit()
