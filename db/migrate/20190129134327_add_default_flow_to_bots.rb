class AddDefaultFlowToBots < ActiveRecord::Migration[5.1]
  def change
    add_column :bots, :default_flow_id, :bigint
    add_foreign_key :bots, :flows, column: 'default_flow_id'
  end
end
