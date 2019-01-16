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
end
