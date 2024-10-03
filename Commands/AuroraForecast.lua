local Client, Message, Arguments, Database = ...

local Characters = "abcdefghijklmnopqrstuvwxyz1234567890"
local RandomAppend = ""

for i = 1, 5 do
    local RandomCharacter = math.random(1, string.len(Characters))
    RandomAppend = RandomAppend..string.sub(Characters, RandomCharacter, RandomCharacter)
end

Message.channel:send {
    content = "This is the latest 24-hour forecast, representing everywhere the aurora is likely to be visible from in the next 24 hours. It shows the Northern Hemisphere only.",
    embed = {
        title = "From NOAA:",
        url = "https://www.swpc.noaa.gov/communities/aurora-dashboard-experimental",
        image = {
            url = "https://services.swpc.noaa.gov/experimental/images/aurora_dashboard/tonights_static_viewline_forecast.png?r="..RandomAppend
        },
        color = 5523574
    },
    reference = {
        message = Message,
        mention = false
    }
}
