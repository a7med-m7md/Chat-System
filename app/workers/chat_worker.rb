require 'sneakers'
require 'json'

class ProcessorChat
  include Sneakers::Worker
  from_queue $chatQueue

  def work(msg)
    message = JSON.parse(msg)
    Chat.create(application_id: message['application_id'], number: message['number'])
    ack!
  end
end