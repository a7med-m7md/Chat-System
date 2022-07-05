class Application < ApplicationRecord
    has_many :chat
    attribute :chats_count, :integer, default: 0
end
