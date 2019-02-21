class AddBotIdToPages < ActiveRecord::Migration[5.1]
  def change
    add_reference :pages, :bot, foreign_key: true
  end
end
