module Statable
  extend ActiveSupport::Concern

  included do
    has_one :state, as: :statable
    has_one :flow, through: :state

    validates :name, presence: true

    def answer(session, message)
      # message = demo_message(text)
      send_message(session, message)
    end

    def send_message(session, message)
      Facebook::Messenger::Bot
        .deliver({
                   recipient: { id: session.sender_id },
                   message: message,
                   message_type: Facebook::Messenger::Bot::MessagingType::UPDATE
                 }, access_token: session.flow.bot.access_token)
    end

    def trigger_payload
      "TRIGGER_STATE_#{id}_PAYLOAD"
    end

    def quick_replies
      state.quick_replies.map do |reply|
        reply.attributes.slice('content_type', 'title', 'payload', 'image_url')
      end
    end

    private

    def demo_message(message)
      {
        text: message,
        quick_replies: [
          {
            content_type: 'text',
            title: 'Hello',
            payload: 'TRIGGER_STATE_2_PAYLOAD'
          },
          {
            content_type: 'text',
            title: 'How are you?',
            payload: 'TRIGGER_STATE_1_PAYLOAD'
          },
          {
            content_type: 'text',
            title: 'Queen',
            payload: 'TRIGGER_STATE_5_PAYLOAD'
          }
        ]
      }
    end
  end
end
