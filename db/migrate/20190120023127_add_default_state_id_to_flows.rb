class AddDefaultStateIdToFlows < ActiveRecord::Migration[5.1]
  def change
    add_column :flows, :default_state_id, :bigint
  end
end
