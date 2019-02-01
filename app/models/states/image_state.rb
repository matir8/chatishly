class ImageState < ApplicationRecord
  include Statable

  validates :url, presence: true

  def handle(session)
    message = if state.quick_replies.any?
                {
                  attachment: attachment,
                  quick_replies: quick_replies
                }
              else
                { attachment: attachment }
              end

    answer(session, message)
  end

  private

  def attachment
    {
      type: 'image',
      payload: {
        url: url
      }
    }
  end
end
