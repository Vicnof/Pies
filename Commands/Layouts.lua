local Client, Message, Arguments = ...

local ValidLayouts = {
    ["1a"] = "Commands/FateLayouts/FateOneA.png",
    ["1b"] = "Commands/FateLayouts/FateOneB.png",
    ["1c"] = "Commands/FateLayouts/FateOneC.png",
    ["1d"] = "Commands/FateLayouts/FateOneD.png",
    ["2a"] = "Commands/FateLayouts/FateTwoA.png",
    ["2b"] = "Commands/FateLayouts/FateTwoB.png",
    ["2c"] = "Commands/FateLayouts/FateTwoC.png",
    ["2d"] = "Commands/FateLayouts/FateTwoD.png",
}

if ValidLayouts[Arguments[2]] then
    Message.channel:send {
        file = ValidLayouts[Arguments[2]],
        reference = {
            message = Message,
            mention = false
        }
    }
end
