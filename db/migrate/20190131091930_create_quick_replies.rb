class CreateQuickReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :quick_replies do |t|
      t.string :content_type
      t.string :title
      t.string :payload
      t.string :image_url
      t.references :state, foreign_key: true

      t.timestamps
    end
  end
end
