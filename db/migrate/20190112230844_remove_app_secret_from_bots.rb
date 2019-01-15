class RemoveAppSecretFromBots < ActiveRecord::Migration[5.1]
  def change
    remove_column :bots, :app_secret, :string
  end
end
