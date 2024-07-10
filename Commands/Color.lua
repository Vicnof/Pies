local Client, Message, Arguments, Database, Timer, HTTP, JSON = ...

if not Arguments[2] then
    Message.channel:send("Whoops, you didn't mention a color.")
    return
end

if string.len(Arguments[2]) ~= 6 and string.len(Arguments[2]) ~= 7 then
    Message.channel:send("Sorry, I only support six-character hex color codes right now.")
    p(Arguments[2])
    return
end

local HexColor = Arguments[2]:match("%x+")

if string.len(HexColor) ~= 6 then
    Message.channel:send("Sorry, I only support six-character hex color codes right now.")
    p(Arguments[2])
    return
end

local Response, Body = HTTP.request("GET", "https://www.thecolorapi.com/scheme?hex="..HexColor.."&format=json&mode=analogic&count=4")

if Response.code ~= 200 then
    Message.channel:send("Sorry, the API this command relies on is down right now.")
    return
end

local ColorData = JSON.decode(Body)

os.execute("convert \""..ColorData["image"]["named"].."\" "..HexColor..".PNG")


Message.channel:send {
    embed = {
        title = "#"..HexColor:lower(),
        description = "**Name**: "..ColorData["seed"]["name"]["value"].."\n**RGB**: "..ColorData["seed"]["rgb"]["value"]:match("[%d,%s%%]+").."\n**HSV**: "..ColorData["seed"]["hsv"]["value"]:match("[%d,%s%%]+").."\n**HSL**: "..ColorData["seed"]["rgb"]["value"]:match("[%d,%s%%]+").."\n**CMYK**: "..ColorData["seed"]["cmyk"]["value"]:match("[%d,%s%%]+").."\n**XYZ**: "..ColorData["seed"]["XYZ"]["value"]:match("[%d,%s%%]+"),
        color = tonumber(HexColor, 16),
        image = {url = "attachment://"..HexColor..".PNG"},
        thumbnail = {url = "https://singlecolorimage.com/get/"..HexColor.."/100x100"},
        fields = {
            {name = ColorData["colors"][1]["name"]["value"], value = "**RGB**: "..ColorData["colors"][1]["rgb"]["value"]:match("[%d,%s%%]+").."\n**HSV**: "..ColorData["colors"][1]["hsv"]["value"]:match("[%d,%s%%]+").."\n**HSL**: "..ColorData["colors"][1]["hsl"]["value"]:match("[%d,%s%%]+").."\n**CMYK**: "..ColorData["colors"][1]["cmyk"]["value"]:match("[%d,%s%%]+").."\n**XYZ**: "..ColorData["colors"][1]["XYZ"]["value"]:match("[%d,%s%%]+"), inline = true},
            {name = ColorData["colors"][2]["name"]["value"], value = "**RGB**: "..ColorData["colors"][2]["rgb"]["value"]:match("[%d,%s%%]+").."\n**HSV**: "..ColorData["colors"][2]["hsv"]["value"]:match("[%d,%s%%]+").."\n**HSL**: "..ColorData["colors"][2]["hsl"]["value"]:match("[%d,%s%%]+").."\n**CMYK**: "..ColorData["colors"][2]["cmyk"]["value"]:match("[%d,%s%%]+").."\n**XYZ**: "..ColorData["colors"][2]["XYZ"]["value"]:match("[%d,%s%%]+"), inline = true},
            {name = ColorData["colors"][3]["name"]["value"], value = "**RGB**: "..ColorData["colors"][3]["rgb"]["value"]:match("[%d,%s%%]+").."\n**HSV**: "..ColorData["colors"][3]["hsv"]["value"]:match("[%d,%s%%]+").."\n**HSL**: "..ColorData["colors"][3]["hsl"]["value"]:match("[%d,%s%%]+").."\n**CMYK**: "..ColorData["colors"][3]["cmyk"]["value"]:match("[%d,%s%%]+").."\n**XYZ**: "..ColorData["colors"][3]["XYZ"]["value"]:match("[%d,%s%%]+"), inline = true},
            {name = ColorData["colors"][4]["name"]["value"], value = "**RGB**: "..ColorData["colors"][4]["rgb"]["value"]:match("[%d,%s%%]+").."\n**HSV**: "..ColorData["colors"][4]["hsv"]["value"]:match("[%d,%s%%]+").."\n**HSL**: "..ColorData["colors"][4]["hsl"]["value"]:match("[%d,%s%%]+").."\n**CMYK**: "..ColorData["colors"][4]["cmyk"]["value"]:match("[%d,%s%%]+").."\n**XYZ**: "..ColorData["colors"][4]["XYZ"]["value"]:match("[%d,%s%%]+"), inline = true},
            --{name = ColorData["colors"][5]["name"]["value"], value = "**RGB**: "..ColorData["colors"][5]["rgb"]["value"]:match("[%d,%s%%]+").."\n**HSV**: "..ColorData["colors"][5]["hsv"]["value"]:match("[%d,%s%%]+").."\n**HSL**: "..ColorData["colors"][5]["hsl"]["value"]:match("[%d,%s%%]+").."\n**CMYK**: "..ColorData["colors"][5]["cmyk"]["value"]:match("[%d,%s%%]+").."\n**XYZ**: "..ColorData["colors"][5]["XYZ"]["value"]:match("[%d,%s%%]+"), inline = true},
            --{name = ColorData["colors"][6]["name"]["value"], value = "**RGB**: "..ColorData["colors"][6]["rgb"]["value"]:match("[%d,%s%%]+").."\n**HSV**: "..ColorData["colors"][6]["hsv"]["value"]:match("[%d,%s%%]+").."\n**HSL**: "..ColorData["colors"][6]["hsl"]["value"]:match("[%d,%s%%]+").."\n**CMYK**: "..ColorData["colors"][6]["cmyk"]["value"]:match("[%d,%s%%]+").."\n**XYZ**: "..ColorData["colors"][6]["XYZ"]["value"]:match("[%d,%s%%]+"), inline = true},
        }
    },
file = HexColor..".PNG"
}

os.execute("rm "..HexColor..".PNG")
