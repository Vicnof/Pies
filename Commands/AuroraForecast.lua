local Client, Message, Arguments, Database = ...

Message.channel:send {
    content = "This is the latest 24-hour forecast, representing everywhere the aurora is likely to be visible from in the next 24 hours. It shows the Northern Hemisphere only.",
    embed = {
        title = "From NOAA:",
        url = "https://www.swpc.noaa.gov/communities/aurora-dashboard-experimental",
        image = {
            url = "https://services.swpc.noaa.gov/experimental/images/aurora_dashboard/tonights_static_viewline_forecast.png"
        },
        color = 5523574
    },
    reference = {
        message = Message,
        mention = false
    }
}