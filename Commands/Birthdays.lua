local Client, Message, Arguments = ...

Message.channel:send {
    embed = {
        title = "Broner Birthdays",
        description = "🎂 NordicGoat: May 10th 2024\n🎂 Smushy: June 27th, 2024\n🎂 Emily: July 7th, 2024\n🎂 Derpy Man: July 30th, 2024    \n🎂 Tzar: August 17th, 2024\n🎂 EE: August 22nd, 2024\n🎂 Elly: August 23rd, 2024\n🎂 Lokloy: January 4th, 2025\n🎂 Rust: April 7th, 2025",
        color = 5019893,
        fields = {
            {name = "Next Birthday", value = "NordicGoat, in 20 days", inline = false}
        },
        footer = {
            text = "Pies | built with <3 by EE"
        }
    }
}
