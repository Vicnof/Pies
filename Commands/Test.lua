local Client, Message, Arguments = ...

 local channel = Client:getChannel('965444906418049084')
  local connection = channel:join()
  connection:playFFmpeg("- $(yt-dlp -x -o - 'https://www.youtube.com/watch?v=RRl_n6yj6U8')")
channel:leave()
