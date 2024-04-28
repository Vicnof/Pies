local Discordia = require("discordia")
local Client = Discordia.Client()

Client:enableAllIntents()

local SQLite = require("sqlite3")
local Database = require("sqlite3").open("Verification.db")
local Prepared = Database:prepare[[
	INSERT INTO VerificationData(UserID, CurrentCode)
	VALUES(?, ?)
	ON CONFLICT(UserID)
	DO UPDATE SET CurrentCode = ?;
]]

local SeverID = "960713019753644032"
local VerificationRoleID = "1225270334043979859"
local NewJoinChannelID = "1225269561419370678"
local Words = {"fluttershy", "twilight", "rarity", "applejack", "pinkie", "rainbow", "braeburn", "soarin", "celestia", "luna", "cadence", "discord", "thorax", "pharynx", "equestria", "ponyville", "scootaloo", "chrysalis", "sombra", "hope", "spike", "shining", "trixie", "zecora", "broner", "pixel", "canterlot", "friendship", "magic", "apples"}

local function GenerateVerificationCode(UserID)
	math.randomseed(os.clock() * os.time())
	local Code = Words[math.random(1, #Words)]
	local Length = math.random(1, 3)

	for i = 1, Length do
		Code = Code.."-"..Words[math.random(1, #Words)]
	end

	local RandomZWS = math.random(1, string.len(Code))
	Code = string.sub(Code, 1, RandomZWS).."​"..string.sub(Code, RandomZWS + 1, -1)
	local Cleared = string.gsub(Code, "​", "")
	Prepared:reset():bind(UserID, Cleared, Cleared):step()
	return Code
end

Client:on("memberJoin", function(Member)
	local Protected, Error = pcall(function()
		local CodeWithZWS = GenerateVerificationCode(Member.user.id)

		local JoinDM = Member:send {
			embed = {
				title = "Hey there!",
				description = "Welcome to Bronercon. We're happy to have you.\n\nUnfortunately, we've been having a bit of a bot problem...\nPlease verify you're a human by replying with the following: **"..CodeWithZWS.."**\n\nIt won't work if you copy and paste.\n\nThank you!",
				color = 15064979,
				footer = {
					text = "Pies | built with ❤️ by EE, pfp art by kryzie"
				}
			}
		}

		if JoinDM == nil then
			Client:getGuild(SeverID):getChannel(NewJoinChannelID):send {
				content = "<@"..Member.user.id..">",
				embed = {
					title = "Hey there!",
					description = "Welcome to Bronercon. We're happy to have you.\nIt looks like your DMs are closed. Please open them temporarily to verify.\n\nUnfortunately, we've been having a bit of a bot problem...\nPlease verify you're a human by DMing me with the following: **"..CodeWithZWS.."**\n\nIt won't work if you copy and paste.\n\nThank you!",
					color = 15064979,
					footer = {
						text = "Pies | built with ❤️ by EE, pfp art by kryzie"
					}
				}
			}
		end
	end)

	if not Protected then
		Client:getUser("240291244306071552"):send {
			embed = {
				title = "Error",
				description = string.sub(Error, 1, 4095),
				color = 14707555,
				fields = {
					{name = "User Trying to Verify", value = "<@"..Member.user.id..">", inline = false},
					{name = "Message", value = string.sub(Message.content, 1, 1023), inline = false}
				}
			}
		}
	end
end)

local Commands = {
	["birthdays"] = loadfile("Commands/Birthdays.lua"),
	["poll"] = loadfile("Commands/TestPoll.lua"),
	["pfp"] = loadfile("Commands/PFP.lua"),
	["lokloy"] = loadfile("Commands/Lokloy.lua"),
	["layout"] = loadfile("Commands/Layouts.lua"),
	["sign"] = loadfile("Commands/Sign.lua"),
	["ping"] = loadfile("Commands/Ping.lua"),
	["floor"] = loadfile("Commands/Floor.lua"),
	["help"] = loadfile("Commands/Help.lua"),
	["nordic"] = loadfile("Commands/Nordic.lua"),
	["testb"] = loadfile("Commands/TestB.lua"),
	["nightmare"] = loadfile("Commands/Nightmare.lua")
}

Client:on("messageCreate", function(Message)
	local Protected, Error = pcall(function()
		if Message.content:lower():sub(1, 2) == "p " or Message.content:lower():sub(1, 5) == "pies " or Message.content:lower():sub(1, 5) == "\240\159\165\167 " or Message.content:lower():sub(1, 23) == "<@1225191085202997343> "  then
			local Arguments = {}

			for Match in Message.content:lower():sub(Message.content:find("%s") + 1):gmatch("%S+") do
				table.insert(Arguments, Match)
			end

			if Commands[Arguments[1]] then
				Commands[Arguments[1]](Client, Message, Arguments, SQLite)
			end

			return
		end

		if Message.channel.type ~= 1 then
			return
		end

		if Message.author.bot == true then
			return
		end


		for _, Role in pairs(Client._api:getGuildMember(SeverID, Message.author.id)["roles"]) do
			if Role == VerificationRoleID then
				Message.channel:send("You're already verified!")
				return
			end
		end

		if Database:exec("SELECT CurrentCode FROM VerificationData WHERE UserID = "..Message.author.id) == nil then
			local CodeWithZWS = GenerateVerificationCode(Message.author.id)
			Message.channel:send("Sorry, it looks like the bot was restarted or your role was removed. Here's a new verification code: **"..CodeWithZWS.."**")
			return
		 end

		if string.find(Message.content, "​") then
			Message.channel:send("Whoops, sorry.\nYou can't copy and paste.")
			return
		end

		local EscapedCode = string.gsub(Database:exec("SELECT CurrentCode FROM VerificationData WHERE UserID = "..Message.author.id)[1][1], "%-", "%%-")
		if not string.match(Message.content:lower(), EscapedCode) then
			local CodeWithZWS = GenerateVerificationCode(Message.author.id)
			Message.channel:send("Whoops, sorry. That wasn't quite right.\nPlease try again with this new code: **"..CodeWithZWS.."**")
			return
		end

		Message.channel:send("Successfully verified! Have fun.")
		Database:exec("DELETE FROM VerificationData WHERE UserID = "..Message.author.id)
		Client:getGuild(SeverID):getMember(Message.author.id):addRole(VerificationRoleID)
	end)

	if not Protected then
		Client:getUser("240291244306071552"):send {
			embed = {
				title = "Error",
				description = string.sub(Error, 1, 4095),
				color = 14707555,
				fields = {
					{name = "User Trying to Verify", value = "<@"..Message.author.id..">", inline = false},
					{name = "Message", value = string.sub(Message.content, 1, 1023), inline = false}
				}
			}
		}
	end
end)

local Token = io.open("Token.txt")
Client:run("Bot "..Token:read())
Token:close()