require 'facebook/messenger'
require 'httparty'

class Bot < ApplicationRecord
  include Facebook::Messenger

  belongs_to :user
  has_many :flows
  belongs_to :default_flow, class_name: 'Flow', foreign_key: 'default_flow_id', optional: true

  validates :verify_token, presence: true
  validates :access_token, presence: true, uniqueness: true
  validates :page_id, presence: true, uniqueness: true
  validates :name, presence: true

  after_create :subscribe_bot

  def subscribe_bot
    facebook_page = user.facebook_pages.find { |page| page['id'] == page_id.to_s }
    query_params = {
      access_token: facebook_page['access_token'],
      subscribed_fields: 'message_deliveries,messages,messaging_optins,messaging_postbacks'
    }

    HTTParty.post("#{ENV['facebook_graph_api']}/#{page_id.to_i}/subscribed_apps/",
                  query: query_params)
  end

  def recipient_info(id)
    facebook_page = user.facebook_pages.find { |page| page['id'] == page_id.to_s }
    query_params = {
      access_token: facebook_page['access_token'],
      subscribed_fields: 'name,profile_pic'
    }

    HTTParty.get("#{ENV['facebook_graph_api']}/#{id}", query: query_params)
  end

  def list_flows_triggers
    flows.collect(&:trigger_payload)
  end

  def configure_persistent_menu(menu)
    default_flow_set?

    Facebook::Messenger::Profile
      .set({
             get_started: {
               payload: default_flow.trigger_payload[:payload]
             },
             persistent_menu: menu
           }, access_token: access_token)
  end

  def delete_persistent_menu
    Facebook::Messenger::Profile
      .unset({ fields: [:persistent_menu] }, access_token: access_token)
  end

  def start_conversation(reply)
    default_flow_set?

    session = BotSession.find_by(sender_id: reply.sender['id'])

    if session.nil?
      recipient = recipient_info(reply.sender['id'])

      session = BotSession.create!(
        current_state_id: default_flow.states.first.id,
        sender_id: recipient['id'],
        sender_name: "#{recipient['first_name']} #{recipient['last_name']}",
        sender_profile_pic: recipient['profile_pic']
      )

      default_flow.start(session)
    elsif message?(reply)
      session.flow.start(session)
    else
      handle_trigger(session, payload(reply))
    end
  end

  private

  def handle_trigger(session, trigger)
    flow = flows.select { |curr_flow| curr_flow.trigger_payload[:payload] == trigger }.first

    if flow.nil?
      flows.includes(:states).each do |curr_flow|
        @state_arr = curr_flow.states.select do |curr_state|
          curr_state.statable.trigger_payload == trigger
        end
        break unless @state_arr.empty?
      end

      state = @state_arr.first
      flow = state.flow

      session.update(current_state_id: state.id)
    else
      session.update(current_state_id: flow.states.first.id)
    end

    flow.start(session)
  end

  def payload(reply)
    reply.messaging.dig('postback', 'payload') ||
      reply.messaging.dig('message', 'quick_reply', 'payload')
  end

  def message?(reply)
    reply.class == Facebook::Messenger::Incoming::Message &&
      reply.messaging.dig('message', 'quick_reply', 'payload').nil?
  end

  def default_flow_set?
    raise 'Default flow is not set' if default_flow.nil?
  end
end
