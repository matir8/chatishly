class TextState < ApplicationRecord
  include Statable

  validates :text, presence: true

  def handle(session)
    answer(session, text)
  end
end
