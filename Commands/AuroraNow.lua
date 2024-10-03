local Client, Message, Arguments, Database = ...

local Characters = "abcdefghijklmnopqrstuvwxyz1234567890"
local RandomAppend = ""

for i = 1, 5 do
    local RandomCharacter = math.random(1, string.len(Characters))
    RandomAppend = RandomAppend..string.sub(Characters, RandomCharacter, RandomCharacter)
end

Message.channel:send {
    content = "This is the lastest 30-minute forecast, representing where the aurora is now. It only shows the Northern Hemisphere.",
    embed = {
        title = "From NOAA:",
        url = "https://www.swpc.noaa.gov/communities/aurora-dashboard-experimental",
        image = {
            url = "https://services.swpc.noaa.gov/images/animations/ovation/north/latest.jpg?r="..RandomAppend
        },
        color = 5523574
    },
    reference = {
        message = Message,
        mention = false
    }
}
