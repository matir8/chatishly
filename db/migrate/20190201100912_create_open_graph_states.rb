class CreateOpenGraphStates < ActiveRecord::Migration[5.1]
  def change
    create_table :open_graph_states do |t|
      t.string :url
      t.string :name

      t.timestamps
    end
  end
end
