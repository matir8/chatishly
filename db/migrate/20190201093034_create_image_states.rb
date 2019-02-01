class CreateImageStates < ActiveRecord::Migration[5.1]
  def change
    create_table :image_states do |t|
      t.string :url
      t.string :name

      t.timestamps
    end
  end
end
