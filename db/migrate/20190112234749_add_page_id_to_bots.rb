class AddPageIdToBots < ActiveRecord::Migration[5.1]
  def change
    add_column :bots, :page_id, :string
  end
end
