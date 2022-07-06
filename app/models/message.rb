require 'elasticsearch/model'
class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :chat
  attribute :number, :integer, default: 0

  def self.chat_search(query, chat_id)
    response = Message.__elasticsearch__.search({
      "query": {
        "bool": {
          "must": {
            "wildcard": { "content": "*#{query}*" }
          },
          "filter": {
            "term": {"chat_id": chat_id}
          }
        }
      }
    })
    return response.records.to_a
  end

end
