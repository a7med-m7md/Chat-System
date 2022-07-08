class AddIndex < ActiveRecord::Migration[5.0]
  def change
    add_index :applications, :token
    add_index :chats, :number
  end
end
