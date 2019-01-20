class QuestionState < ApplicationRecord
  include Statable

  validates :question, presence: true

  def handle
    answer do |message|
      message.reply(text: question)
    end
  end
end
