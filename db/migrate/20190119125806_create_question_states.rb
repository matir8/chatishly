class CreateQuestionStates < ActiveRecord::Migration[5.1]
  def change
    create_table :question_states do |t|
      t.timestamps
    end
  end
end
