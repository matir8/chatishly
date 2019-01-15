# frozen_string_literal: true
require 'koala'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :bots

  def facebook_pages
    @graph = Koala::Facebook::API.new(self['social_access_tokens']['facebook'])
    @graph.get_connections('me', 'accounts')
  end
end
