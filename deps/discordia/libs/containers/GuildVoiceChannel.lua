--[=[
@c GuildVoiceChannel x GuildChannel
@d Represents a voice channel in a Discord guild, where guild members can connect
and communicate via voice chat.
]=]

local json = require('json')

local GuildChannel = require('containers/abstract/GuildChannel')
local VoiceConnection = require('voice/VoiceConnection')
local TableIterable = require('iterables/TableIterable')
local TextChannel = require('containers/abstract/TextChannel')
local FilteredIterable = require('iterables/FilteredIterable')
local Webhook = require('containers/Webhook')
local Cache = require('iterables/Cache')
local Resolver = require('client/Resolver')

local GuildVoiceChannel, get = require('class')('GuildVoiceChannel', GuildChannel, TextChannel)

function GuildVoiceChannel:__init(data, parent)
	GuildChannel.__init(self, data, parent)
	TextChannel.__init(self, data, parent)
end

function GuildVoiceChannel:_load(data)
	GuildChannel._load(self, data)
	TextChannel._load(self, data)
end

--[=[
@m setBitrate
@t http
@p bitrate number
@r boolean
@d Sets the channel's audio bitrate in bits per second (bps). This must be between
8000 and 96000 (or 128000 for partnered servers). If `nil` is passed, the
default is set, which is 64000.
]=]
function GuildVoiceChannel:setBitrate(bitrate)
	return self:_modify({bitrate = bitrate or json.null})
end

--[=[
@m setUserLimit
@t http
@p user_limit number
@r boolean
@d Sets the channel's user limit. This must be between 0 and 99 (where 0 is
unlimited). If `nil` is passed, the default is set, which is 0.
]=]
function GuildVoiceChannel:setUserLimit(user_limit)
	return self:_modify({user_limit = user_limit or json.null})
end

--[=[
@m join
@t ws
@r VoiceConnection
@d Join this channel and form a connection to the Voice Gateway.
]=]
function GuildVoiceChannel:join()

	local success, err

	local connection = self._connection

	if connection then

		if connection._ready then
			return connection
		end

	else

		local guild = self._parent
		local client = guild._parent

		success, err = client._shards[guild.shardId]:updateVoice(guild._id, self._id)

		if not success then
			return nil, err
		end

		connection = guild._connection

		if not connection then
			connection = VoiceConnection(self)
			guild._connection = connection
		end

		self._connection = connection

	end

	success, err = connection:_await()

	if success then
		return connection
	else
		return nil, err
	end

end

--[=[
@m leave
@t http
@r boolean
@d Leave this channel if there is an existing voice connection to it.
Equivalent to GuildVoiceChannel.connection:close()
]=]
function GuildVoiceChannel:leave()
	if self._connection then
		return self._connection:close()
	else
		return false, 'No voice connection exists for this channel'
	end
end

--[=[@p bitrate number The channel's bitrate in bits per second (bps). This should be between 8000 and
96000 (or 128000 for partnered servers).]=]
function get.bitrate(self)
	return self._bitrate
end

--[=[@p userLimit number The amount of users allowed to be in this channel.
Users with `moveMembers` permission ignore this limit.]=]
function get.userLimit(self)
	return self._user_limit
end

--[=[@p connectedMembers TableIterable An iterable of all users connected to the channel.]=]
function get.connectedMembers(self)
	if not self._connected_members then
		local id = self._id
		local members = self._parent._members
		self._connected_members = TableIterable(self._parent._voice_states, function(state)
			return state.channel_id == id and members:get(state.user_id)
		end)
	end
	return self._connected_members
end

--[=[@p connection VoiceConnection/nil The VoiceConnection for this channel if one exists.]=]
function get.connection(self)
	return self._connection
end

--[=[
@m createWebhook
@t http
@p name string
@r Webhook
@d Creates a webhook for this channel. The name must be between 2 and 32 characters
in length.
]=]
function GuildVoiceChannel:createWebhook(name)
	local data, err = self.client._api:createWebhook(self._id, {name = name})
	if data then
		return Webhook(data, self.client)
	else
		return nil, err
	end
end

--[=[
@m getWebhooks
@t http
@r Cache
@d Returns a newly constructed cache of all webhook objects for the channel. The
cache and its objects are not automatically updated via gateway events. You must
call this method again to get the updated objects.
]=]
function GuildVoiceChannel:getWebhooks()
	local data, err = self.client._api:getChannelWebhooks(self._id)
	if data then
		return Cache(data, Webhook, self.client)
	else
		return nil, err
	end
end

--[=[
@m bulkDelete
@t http
@p messages Message-ID-Resolvables
@r boolean
@d Bulk deletes multiple messages, from 2 to 100, from the channel. Messages over
2 weeks old cannot be deleted and will return an error.
]=]
function GuildVoiceChannel:bulkDelete(messages)
	messages = Resolver.messageIds(messages)
	local data, err
	if #messages == 1 then
		data, err = self.client._api:deleteMessage(self._id, messages[1])
	else
		data, err = self.client._api:bulkDeleteMessages(self._id, {messages = messages})
	end
	if data then
		return true
	else
		return false, err
	end
end

--[=[
@m setRateLimit
@t http
@p limit number
@r boolean
@d Sets the channel's slowmode rate limit in seconds. This must be between 0 and 120.
Passing 0 or `nil` will clear the limit.
]=]
function GuildVoiceChannel:setRateLimit(limit)
	return self:_modify({rate_limit_per_user = limit or json.null})
end

--[=[
@m enableNSFW
@t http
@r boolean
@d Enables the NSFW setting for the channel. NSFW channels are hidden from users
until the user explicitly requests to view them.
]=]
function GuildVoiceChannel:enableNSFW()
	return self:_modify({nsfw = true})
end

--[=[
@m disableNSFW
@t http
@r boolean
@d Disables the NSFW setting for the channel. NSFW channels are hidden from users
until the user explicitly requests to view them.
]=]
function GuildVoiceChannel:disableNSFW()
	return self:_modify({nsfw = false})
end

--[=[@p topic string/nil The channel's topic. This should be between 1 and 1024 characters.]=]
function get.topic(self)
	return self._topic
end

--[=[@p nsfw boolean Whether this channel is marked as NSFW (not safe for work).]=]
function get.nsfw(self)
	return self._nsfw or false
end

--[=[@p rateLimit number Slowmode rate limit per guild member.]=]
function get.rateLimit(self)
	return self._rate_limit_per_user or 0
end

--[=[@p isNews boolean Whether this channel is a news channel of type 5.]=]
function get.isNews(self)
	return self._type == 5
end

--[=[@p members FilteredIterable A filtered iterable of guild members that have
permission to read this channel. If you want to check whether a specific member
has permission to read this channel, it would be better to get the member object
elsewhere and use `Member:hasPermission` rather than check whether the member
exists here.]=]
function get.members(self)
	if not self._members then
		self._members = FilteredIterable(self._parent._members, function(m)
			return m:hasPermission(self, 'readMessages')
		end)
	end
	return self._members
end

return GuildVoiceChannel
