local Client, Message, Arguments, Database = ...

if not Database then
    return
end

local Months = {"January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}
local Days = {"1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th", "11th", "12th", "13th", "14th", "15th", "16th", "17th", "18th", "19th", "20th", "21st", "22nd", "23rd", "24th", "25th", "26th", "27th", "28th", "29th", "30th", "31st"}

local Month = tonumber(Arguments[2]:match("%d+"), 10)
local Day = tonumber(Arguments[2]:reverse():match("%d+"):reverse(), 10)

if Month < 1 or Month > 12 or not then
	Message.channel:send {
		content = "Invalid month, please set your birthday in the format MM/DD.",
		reference = {
			message = Message,
			mention = false
		}
	}
	return
end

if Day < 1 or Day > 31 or not Day then
	Message.channel:send {
		content = "Invalid day, please set your birthday in the format MM/DD.",
		reference = {
			message = Message,
			mention = false
		}
	}
	return
end

local Prepared = Database:prepare[[
	INSERT INTO Birthdays(UserID, Birthday)
	VALUES(?, ?)
	ON CONFLICT(UserID)
	DO UPDATE SET Birthday = ?;
]]

Prepared:reset():bind(Message.author.id, Month.."/"..Day, Month.."/"..Day):step()

Message.channel:send {
	content = "Successfully set your birthday to "..Months[Month].." "..Days[Day],
	reference = {
		message = Message,
		mention = false
	}
}
