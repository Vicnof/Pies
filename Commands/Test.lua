local Command, Message, Arguments = ...

local Amount = tonumber(Arguments[2])
Message.channel:send(tostring(Amount))
local DAO = 32

local Chase, Wells, America, Robinhood, Kinecta, First

if Amount > (500 + DAO) then
    Amount = Amount - DAO
    print(Amount)
    Chase = math.floor(75 + ((Amount - 500) * 0.10))
    Wells = math.floor(75 + ((Amount - 500) * 0.10))
    America = math.floor(25 + ((Amount - 500) * 0.05))
    Robinhood = math.floor(250 + ((Amount - 500) * 0.65))
	First = math.floor(75 + ((Amount - 500) * 0.10))
end

if Amount < (500 + DAO) then
    Amount = Amount - DAO
    Chase = math.floor(Amount * 0.15)
    Wells = math.floor(Amount * 0.15)
    America = math.floor(Amount * 0.05)
    Robinhood = math.floor(Amount * 0.50)
	First = math.floor(Amount * 0.15)
end

Message.channel:send("Chase: $"..Chase.."\n".."Wells: $"..Wells.."\n".."America: $"..America.."\n".."Robinhood: $"..Robinhood.."\n".."$"..Amount - (Chase + Wells + America + Robinhood).." left over")

Message.channel:send {
	content = "Chase: $"..Chase.."\n".."Wells: $"..Wells.."\n".."America: $"..America.."\n".."Robinhood: $"..Robinhood.."\n".."$"..Amount - (Chase + Wells + America + Robinhood).." left over",
	reference = {
		message = Message,
		mention = true
	}
}
