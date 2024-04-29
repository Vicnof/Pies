Dlocal Client, Message, Arguments = ...

Message.channel:send {
    poll = {
        question = {text = "Will this test work?"},
        answers = {
            {answer_id = 1, poll_media = {text = "Option One"}},
            {answer_id = 2, poll_media = {text = "Option One"}}
        },
        duration = 24,
        allow_multiselect = true
    }
}