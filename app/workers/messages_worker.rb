require 'sneakers'
require 'json'

class ProcessorMessage
  include Sneakers::Worker
  from_queue $messageQueue
  
  def work(msg)
    message = JSON.parse(msg)
    Message.create(chat_id: message['chat_id'], content: message['content'], number: message['number'])
    ack!
  end
end