class QuestionState < ApplicationRecord
  include Statable

  validates :question, presence: true

  def handle(session)
    message = if state.quick_replies.any?
                {
                  text: question,
                  quick_replies: quick_replies
                }
              else
                { text: question }
              end

    answer(session, message)
  end
end
