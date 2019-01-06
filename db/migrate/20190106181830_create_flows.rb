class CreateFlows < ActiveRecord::Migration[5.1]
  def change
    create_table :flows do |t|
      t.references :bot, foreign_key: true

      t.timestamps
    end
  end
end
