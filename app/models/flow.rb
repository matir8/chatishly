class Flow < ApplicationRecord
  belongs_to :bot

  has_many :states
  has_many :text_states, through: :states, source: :statable, source_type: 'TextState', class_name: 'TextState'
  has_many :question_states, through: :states, source: :statable, source_type: 'QuestionState', class_name: 'QuestionState'

  validates :name, presence: true

  def start
    states.each do |state|
      state.statable.handle
    end
  end
end
