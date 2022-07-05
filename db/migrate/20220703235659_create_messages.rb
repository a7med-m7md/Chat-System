class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :chat, foreign_key: true
      t.bigint :number, null: false

      t.timestamps
    end
  end
end
