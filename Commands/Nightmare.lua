local Client, Message, Arguments = ...

Message.channel:send {
	embed = {
		description = "``1. Get the Lantern.``\n :black_small_square: a. Walk to Floor 108 (108 Floors)\n :black_small_square: b. Type \"Floor 9\" into the Lectern to be teleported to Floor 7219.\n :black_small_square: c. Walk to Floor 7307 (88 Floors) and get captured by Be Quiet. \n :black_small_square: d. Obtain the Lantern in the tragic maze. \n :black_small_square: e. Take the waking up door that teleports you back to Floor 10. \n ``2. Teleport to Floor -1001 via the nightmare badge. ``\n :black_small_square: a. Walk to Floor 108. (98 Floors)\n :black_small_square: b. Type \"Floor 9\" into the Lectern to be teleported to Floor 7219.\n :black_small_square: c. Walk back down to Floor 7148 to access the Nightmare Floors (71 Floors)\n :black_small_square: d. Find a tentacle monster and obtain the Nightmare Key using the Lantern.\n :black_small_square: e. Find a ceiling door in one of the Nightmare Floors to obtain the 5 codes.\n :black_small_square: f. Reset back to Floor 0 after passing through the black portal.\n :black_small_square: g. Type /e d and \\ into the chat to open the console and debug menu. Prepend s0_ to your codes and type them into the console to highlight each sign.\n :black_small_square: h. Find the Nth character in each sign, at the end of each line.\n :black_small_square: i. You'll get five characters, put them in order and this is the server's nightmare code.\n :black_small_square: j. walk back to Floor 108. (108 Floors)\n :black_small_square: k. Type the decoded answer into the Lectern to be teleported to Floor -1001.",
		fields = {
			{name = "Credit", value = "Lokloy & the *A Dream You've Had Before* wiki authors", inline = false}
		},
		color = 16146908
	},
	reference = {
		message = Message,
		mention = false
	}
}
