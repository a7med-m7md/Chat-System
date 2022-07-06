class Chat < ApplicationRecord
  belongs_to :application
  has_many :message
  attribute :messages_count, :integer, default: 0
  validates :number, numericality: { greater_than: 0 }
  validates_uniqueness_of :number, scope: :application_id
end
