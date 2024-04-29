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

local Birthday = {
    ["year"] = tonumber(os.date("%Y")),
    ["month"] = Month,
    ["day"] = Day,
    ["hour"] = 4
}

if os.time(Birthday) < os.time() then
    Birthday["year"] = tonumber(os.date("%Y")) + 1
end

Message.channel:send {
    content = Months[Month].." "..Days[Day]..", "..tostring(tonumber(os.date("%Y") + 1)).."\nor <t:"..os.time(Birthday)..":R>",
    reference = {
        message = Message,
        mention = false
    }
}