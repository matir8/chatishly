class CreateTextStates < ActiveRecord::Migration[5.1]
  def change
    create_table :text_states do |t|
      t.timestamps
    end
  end
end
