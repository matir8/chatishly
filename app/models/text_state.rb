class TextState < ApplicationRecord
  include Statable

  validates :text, presence: true

  def handle
    answer do |message|
      message.reply(text: text)
      next
    end
  end
end
