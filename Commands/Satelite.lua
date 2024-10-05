local Client, Message, Arguments, Database = ...

local ValidArguments = {
  ["west"] = {"https://cdn.star.nesdis.noaa.gov/GOES18/ABI/SECTOR/wus/GEOCOLOR/latest.jpg", "https://cdn.star.nesdis.noaa.gov/GOES18/ABI/SECTOR/wus/GEOCOLOR/GOES18-WUS-GEOCOLOR-1000x1000.gif", "This is the latest satelite image of the Western United States. It is usually no more than an hour old. During the day, it shows a real-color view, and uses IR at night.", "This is the latest satelite gif of the Western United States. It shows the past few hours. During the day, it shows a real-color view, and uses IR at night."},
  ["east"] = {"https://cdn.star.nesdis.noaa.gov/GOES16/ABI/SECTOR/eus/GEOCOLOR/latest.jpg", "https://cdn.star.nesdis.noaa.gov/GOES16/ABI/SECTOR/eus/GEOCOLOR/GOES16-EUS-GEOCOLOR-1000x1000.gif", "This is the latest satelite image of the Western United States. It is usually no more than an hour old. During the day, it shows a real-color view, and uses IR at night.", "This is the latest satelite gif of the Eastern United States. It shows the past few hours. During the day, it shows a real-color view, and uses IR at night."},
  ["us"] = {"https://cdn.star.nesdis.noaa.gov/GOES16/ABI/CONUS/GEOCOLOR/latest.jpg", "https://cdn.star.nesdis.noaa.gov/GOES16/ABI/CONUS/GEOCOLOR/GOES16-CONUS-GEOCOLOR-625x375.gif", "This is the latest satelite image of the continental United States. It is usually no more than an hour old. During the day, it shows a real-color view, and it uses IR at night.", "This is the latest satelite gif of the continental United States. It shows the pat few hours. During the day, it shows a real-color view, and uses IR at night."}
}

if Arguments[2] == nil or ValidArguments[string.lower(Arguments[2])] == nil then
	Message.channel:send("This command brings up the latest satelite images of the continental United States from NOAA.\n\nTo use it, the first parameter indicates whether you want a view of the `west` coast, `east` coast, or the entire `us`.\nThe second is whether you want the latest static image, or a `gif`.\n\nE.g.,\n`p satelite west` would bring up the latest satelite image of the Western United States.\n`p satelite east gif` would bring up a gif of the latest satelite images of the Eastern United States.\n`p satelite us gif` would do the same, but for the entire continental United States.")
	return
end

local Characters = "abcdefghijklmnopqrstuvwxyz1234567890"
local RandomAppend = ""

for i = 1, 5 do
    local RandomCharacter = math.random(1, string.len(Characters))
    RandomAppend = RandomAppend..string.sub(Characters, RandomCharacter, RandomCharacter)
end

local Description
local URL

if Arguments[3] and string.lower(Arguments[3]) == "gif" then
	Description = ValidArguments[Arguments[2]][4]
	URL = ValidArguments[Arguments[2]][2]
else
	Description = ValidArguments[Arguments[2]][3]
		URL = ValidArguments[Arguments[2]][1]
end

Message.channel:send {
    content = Description,
    embed = {
        title = "From NOAA:",
        url = "https://www.star.nesdis.noaa.gov/goes/index.php",
        image = {
            url = URL--.."?r="..RandomAppend
        },
        color = 165
    },
    reference = {
        message = Message,
        mention = false
    }
}
