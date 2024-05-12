local Client, Message, Arguments, Database = ...

Message.channel:send {
    content = "This is the lastest 30-minute forecast, representing where the aurora is now. It shows the Northern Hemisphere only.",
    embed = {
        title = "From NOAA:",
        url = "https://www.swpc.noaa.gov/communities/aurora-dashboard-experimental",
        image = {
            url = "https://services.swpc.noaa.gov/images/animations/ovation/north/latest.jpg"
        },
        color = 5523574
    },
    reference = {
        message = Message,
        mention = false
    }
}