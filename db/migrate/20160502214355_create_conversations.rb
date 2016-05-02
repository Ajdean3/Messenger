class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.integer :receiver_id
      t.integer :sender_id
      t.integer :message_count

      t.timestamps
    end
  end
end
