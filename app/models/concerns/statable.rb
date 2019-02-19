module Statable
  extend ActiveSupport::Concern

  included do
    has_one :state, as: :statable
    has_one :flow, through: :state

    validates :name, presence: true

    def answer(session, message)
      Facebook::Messenger::Bot
        .deliver({
                   recipient: { id: session.sender_id },
                   message: message,
                   message_type: Facebook::Messenger::Bot::MessagingType::UPDATE
                 }, access_token: session.flow.bot.access_token)
    end

    def trigger_payload
      "TRIGGER_STATE_#{state.id}_PAYLOAD"
    end

    def quick_replies
      state.quick_replies.map do |reply|
        reply.attributes.slice('content_type', 'title', 'payload', 'image_url')
      end
    end
  end
end
