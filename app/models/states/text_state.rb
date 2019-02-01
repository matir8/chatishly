class TextState < ApplicationRecord
  include Statable

  validates :text, presence: true

  def handle(session)
    message = if state.quick_replies.any?
                {
                  text: text,
                  quick_replies: quick_replies
                }
              else
                { text: text }
              end

    answer(session, message)
  end
end
