local Client, Message, Arguments = ...

 local channel = Client:getChannel('965444906418049084')
  local connection = channel:join()
  connection:playFFmpeg('Commands/Alice.mp3')
