class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.string :access_token, null: false
      t.string :category, null: false
      t.string :name, null: false
      t.string :facebook_id, null: false
      t.text :category_list, array: true, default: []
      t.text :tasks, array: true, default: []
      t.references :user, null: false

      t.timestamps
    end
  end
end
