class AddSenderNameAndSenderProfilePicToBotSessions < ActiveRecord::Migration[5.1]
  def change
    add_column :bot_sessions, :sender_name, :string
    add_column :bot_sessions, :sender_profile_pic, :string
  end
end
