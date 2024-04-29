local Client, Message, Arguments, Database = ...

local Month = tonumber(Arguments[2]:match("%d+"), 10)
local Day = tonumber(Arguments[2]:reverse():match("%d+"):reverse(), 10)

local Months = {"January", "Febuary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}
local Days = {"1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th", "11th", "12th", "13th", "14th", "15th", "16th", "17th", "18th", "19th", "20th", "21st", "22nd", "23rd", "24th", "25th", "26th", "27th", "28th", "29th", "30th", "31st"}

if Month < 1 or Month > 12 or Month == nil then
    Message.channel:send {
        content = "Invalid month, please set your birthday in the format MM/DD.",
        reference = {
            message = Message,
            mention = false
        }
    }
    return
end

if Day < 1 or Day > 31 or Day == nil then
    Message.channel:send {
        content = "Invalid day, please set your birthday in the format MM/DD.",
        reference = {
            message = Message,
            mention = false
        }
    }
    return
end

local LocalizedBirthdayTimestamp = os.time{
    ["year"] = tonumber(os.date("%Y")),
    ["month"] = Month,
    ["day"] = Day,
    ["hour"] = 0,
    isdst = false
}

local UTCBirthdayTimestamp = os.time(os.date("!*t", LocalizedBirthdayTimestamp))
local MidnightUTCBirthdayTimestamp = (LocalizedBirthdayTimestamp - math.floor(os.difftime(LocalizedBirthdayTimestamp, UTCBirthdayTimestamp)))
local Birthday = os.date("!*t", MidnightUTCBirthdayTimestamp)

local OffsetFromUTC = -5
if os.date("*t", os.time())["isdst"] then
    OffsetFromUTC = -4
end

Birthday["hour"] = Birthday["hour"] - OffsetFromUTC

local Prepared = Database:prepare[[
    INSERT INTO Birthdays(UserID, BirthdayTimestamp)
	VALUES(?, ?)
	ON CONFLICT(UserID)
	DO UPDATE SET BirthdayTimestamp = ?;
]]

Prepared:reset():bind(Message.author.id, tostring(os.time(Birthday)), tostring(os.time(Birthday))):step()

local Get = Database:exec[[
    SELECT UserID, BirthdayTimestamp FROM Birthdays
    ORDER BY CAST (BirthdayTimestamp AS INTEGER) ASC;
]]

local BirthdayText = ""

for Index, Timestamp in pairs(Get[2]) do
    BirthdayText = BirthdayText.."🎂 <@"..Get[1][Index]..">: "..os.date("%B %d, %Y", os.time(Birthday)).."\n"
end

local Days = math.ceil((Get[2][1] - os.time()) / 86400) - 1

if Days == 0 then
    Message.channel:send {
    embed = {
        title = "Broner Birthdays",
        description = BirthdayText,
        color = 5019893,
        fields = {
            {name = "Next Birthday", value = "It's <@"..Get[1][1]..">'s birthday!", inline = false}
        },
        footer = {
            text = "Pies | built with <3 by EE"
        }
    }
}
return
end

Message.channel:send {
    embed = {
        title = "Broner Birthdays",
        description = BirthdayText,
        color = 5019893,
        fields = {
            {name = "Next Birthday", value = "<@"..Get[1][1]..">, in "..Days.." days", inline = false}
        },
        footer = {
            text = "Pies | built with <3 by EE"
        }
    }
}