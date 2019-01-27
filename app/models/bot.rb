require 'facebook/messenger'
require 'httparty'

class Bot < ApplicationRecord
  include Facebook::Messenger

  belongs_to :user
  has_many :flows

  validates :verify_token, presence: true
  validates :access_token, presence: true, uniqueness: true
  validates :page_id, presence: true, uniqueness: true
  validates :name, presence: true

  def subscribe_bot
    facebook_page = user.facebook_pages.find { |page| page['id'] == page_id.to_s }
    query_params = {
      access_token: facebook_page['access_token'],
      subscribed_fields: 'message_deliveries,messages,messaging_optins,messaging_postbacks'
    }
    HTTParty.post("#{ENV['facebook_graph_api']}/#{page_id.to_i}/subscribed_apps/",
                  query: query_params)
  end

  def list_triggers
    flows.collect(&:trigger_payload)
  end

  def configure_persistent_menu(_menu)
    Facebook::Messenger::Profile
      .set({
             get_started: {
               payload: 'GET_STARTED_PAYLOAD'
             },
             # persistent_menu: menu
             persistent_menu: demo_menu
           }, access_token: access_token)
  end

  def start_conversation(reply)
    session = FlowSession.find_by(sender_id: reply.sender['id'])

    if session.nil?
      # create session
      flows.first.start(reply)
    else
      if message?(reply)
        session.flow.start(reply)
      else
        trigger = payload(reply)
        session.update(current_state_id: session.flow.states.first.id)
        flows.select { |flow| flow.trigger_payload == trigger }.first.start(reply)
      end
    end
  end

  private

  def payload(reply)
    reply.messaging.dig('postback', 'payload') ||
      reply.messaging.dig('message', 'quick_reply', 'payload')
  end

  def message?(reply)
    reply.class == Facebook::Messenger::Incoming::Message &&
      reply.messaging.dig('message', 'quick_reply', 'payload').nil?
  end

  def demo_menu
    [
      {
        locale: 'default',
        composer_input_disabled: false,
        call_to_actions: [
          {
            title: 'Sample Flow',
            type: 'postback',
            payload: 'TRIGGER_SAMPLE_FLOW_PAYLOAD'
          },
          {
            title: 'Demo Flow',
            type: 'postback',
            payload: 'TRIGGER_DEMO_FLOW_PAYLOAD'
          }
        ]
      }
    ]
  end
end
