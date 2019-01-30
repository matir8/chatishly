class RemoveDefaultStateIdFromFlows < ActiveRecord::Migration[5.1]
  def change
    remove_column :flows, :default_state_id
  end
end
