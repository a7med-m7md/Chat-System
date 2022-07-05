class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :applications  do |t|
      t.string :token
      t.integer :chats_count
      t.string :name

      t.timestamps
    end
  end
end
