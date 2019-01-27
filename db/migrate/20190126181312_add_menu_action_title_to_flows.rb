class AddMenuActionTitleToFlows < ActiveRecord::Migration[5.1]
  def change
    add_column :flows, :menu_action_title, :string
  end
end
