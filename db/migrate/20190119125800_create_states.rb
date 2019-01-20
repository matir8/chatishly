class CreateStates < ActiveRecord::Migration[5.1]
  def change
    create_table :states do |t|
      t.references :flow, foreign_key: true
      t.references :statable, polymorphic: true

      t.timestamps
    end
  end
end
