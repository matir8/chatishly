# frozen_string_literal: true
require 'koala'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :bots
  has_many :pages

  def facebook_pages
    @graph = Koala::Facebook::API.new(self['social_access_tokens']['facebook'])
    @new_pages = @graph.get_connections('me', 'accounts')

    @new_pages.each do |new_page|
      Page.where(facebook_id: new_page['id']).first_or_create! do |page|
        page.user_id = id
        page.access_token = new_page['access_token']
        page.name = new_page['name']
        page.facebook_id = new_page['id']
        page.category = new_page['category']
        page.category_list = new_page['category_list']
        page.tasks = new_page['tasks']
      end
    end
  end
end
