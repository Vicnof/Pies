local Commands, Message, Arguments = ...

 local channel = client:getChannel('965444906418049084')
  local connection = channel:join()
  connection:playFFmpeg('Alice.mp3')
channel:leave()
