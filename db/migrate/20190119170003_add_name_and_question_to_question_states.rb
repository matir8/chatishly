class AddNameAndQuestionToQuestionStates < ActiveRecord::Migration[5.1]
  def change
    add_column :question_states, :name, :string
    add_column :question_states, :question, :text
  end
end
