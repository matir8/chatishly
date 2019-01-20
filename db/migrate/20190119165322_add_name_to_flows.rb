class AddNameToFlows < ActiveRecord::Migration[5.1]
  def change
    add_column :flows, :name, :string
  end
end
