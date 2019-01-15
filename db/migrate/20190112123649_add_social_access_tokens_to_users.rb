class AddSocialAccessTokensToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :social_access_tokens, :json
  end
end
