class QuestionState < ApplicationRecord
  include Statable

  validates :question, presence: true

  def handle(session)
    message = if state.quick_replies.any?
                {
                  text: question,
                  quick_replies: state.quick_replies.select(&:attributes)
                }
              else
                { text: question }
              end

    answer(session, message)
  end
end
