class AddNameAndTextToTextStates < ActiveRecord::Migration[5.1]
  def change
    add_column :text_states, :name, :string
    add_column :text_states, :text, :string
  end
end
