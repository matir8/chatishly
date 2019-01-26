class QuestionState < ApplicationRecord
  include Statable

  validates :question, presence: true

  def handle(session)
    answer(session, question)
  end
end
