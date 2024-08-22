local Client, Message, Arguments, Database = ...

if not Database then
    return
end

local Months = {"January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}
local Days = {"1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th", "11th", "12th", "13th", "14th", "15th", "16th", "17th", "18th", "19th", "20th", "21st", "22nd", "23rd", "24th", "25th", "26th", "27th", "28th", "29th", "30th", "31st"}

local Get = Database:exec[[
	SELECT UserID, Birthday FROM Birthdays;
]]

local Birthdays = {}

for Index, Birthday in pairs(Get[2]) do

	local Month = tonumber(Birthday:match("%d+"), 10)
	local Day = tonumber(Birthday:reverse():match("%d+"):reverse(), 10)

	local BirthdayTable = {
		year = os.date("*t", os.time())["year"],
		month = Month,
		day = Day
	}

	-- Convert to timestamp

	if os.time(BirthdayTable) < (os.time() - 86400) then
		BirthdayTable["year"] = BirthdayTable["year"] + 1
	end

	table.insert(Birthdays, {Get[1][Index], os.time(BirthdayTable), Month, Day, BirthdayTable["year"]})
end

local function Sort(One, Two)
	if One[2] < Two[2] then
		return true
	end
end

table.sort(Birthdays, Sort)

local BirthdayText = ""

for _, Array in pairs(Birthdays) do
	BirthdayText = BirthdayText.."🎂 <@"..Array[1]..">: "..Months[Array[3]].." "..Days[Array[4]]..", "..Array[5].."\n"
end
Client:getUser(240291244306071552):send("```"..BirthdayText.."```")
local Days = math.ceil((Birthdays[1][2] - os.time()) / 86400) - 1

if Days <= 1 then
	Message.channel:send {
		content = "You can set your birthday via `p setbirthday MM/DD`.",    
		embed = {
			title = "Broner Birthdays",
			description = BirthdayText,
			color = 5019893,
			fields = {
				{name = "Next Birthday", value = "It's <@"..Birthdays[1][1]..">'s birthday!", inline = false}
			},
			footer = {
				text = "Pies | built with <3 by EE"
			}
		}
	}
	return
end

Message.channel:send {
	content = "You can set your birthday via `p setbirthday MM/DD`.",
	embed = {
		title = "Broner Birthdays",
		description = BirthdayText,
		color = 5019893,
		fields = {
			{name = "Next Birthday", value = "<@"..Birthdays[1][1]..">, in "..Days.." days", inline = false}
		},
		footer = {
			text = "Pies | built with <3 by EE"
		}
	}
}
