# class PublishHandler
#     def send_message(queue_name, messageObject)
#         channel = $bunnyConnection.create_channel
#         queue = channel.queue(queue_name, durable: true)
#         queue.publish(messageObject.to_json, routing_key: queue.name)
#     end
# end