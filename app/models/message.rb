class Message < ApplicationRecord
  belongs_to :chat
  attribute :number, :integer, default: 0
end
