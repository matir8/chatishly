class CreateFlowSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :flow_sessions do |t|
      t.string :sender_id
      t.references :flow, foreign_key: true
      t.references :current_state

      t.timestamps
    end

    add_foreign_key :flow_sessions, :states, column: :current_state_id, primary_key: :id
  end
end
