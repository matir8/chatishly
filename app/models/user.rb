# frozen_string_literal: true
require 'koala'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :bots, dependent: :destroy
  has_many :pages, dependent: :destroy

  def facebook_pages
    @graph = Koala::Facebook::API.new(self['social_access_tokens']['facebook'])
    @new_pages = @graph.get_connections('me', 'accounts')

    @new_pages.each do |new_page|
      page = Page.find_by(facebook_id: new_page['id'])

      if page.nil?
        Page.create(page_params(new_page))
      else
        Page.update(page_params(new_page))
      end
    end
  end

  private

  def page_params(new_page)
    {
      user_id: id,
      access_token: new_page['access_token'],
      name: new_page['name'],
      facebook_id: new_page['id'],
      category: new_page['category'],
      category_list: new_page['category_list'],
      tasks: new_page['tasks']
    }
  end
end
