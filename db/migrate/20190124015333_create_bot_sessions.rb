class CreateBotSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :bot_sessions do |t|
      t.string :sender_id
      t.references :current_state

      t.timestamps
    end
  end
end
