require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every '10s' do
    Application.all.each do |application|
        application.chats_count = application.chat.count
        application.save
    end

    Chat.all.each do |chat|
        chat.messages_count = chat.message.count
        chat.save
    end
end
