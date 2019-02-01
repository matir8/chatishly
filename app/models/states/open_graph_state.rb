class OpenGraphState < ApplicationRecord
  include Statable

  validates :url, presence: true

  def handle(session)
    message = if state.quick_replies.any?
                {
                  attachment: attachment,
                  quick_replies: state.quick_replies.select(&:attributes)
                }
              else
                { attachment: attachment }
              end

    answer(session, message)
  end

  private

  def attachment
    {
      type: 'template',
      payload: {
        template_type: 'open_graph',
        elements: [
          { url: url }
        ]
      }
    }
  end
end
