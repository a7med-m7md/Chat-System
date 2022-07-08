$bunnyConnection = Bunny.new(:host => ENV['RABBITMQ_HOST'], )
$bunnyConnection.start

$chatQueue = 'pendingChats'
$messageQueue = 'pendingMessages'
