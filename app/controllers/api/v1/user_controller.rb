module Api::V1
  class UserController < ApiController
    before_action :authenticate_user!

    def current
      render json: current_user
    end

    def facebook_pages
      if current_user.facebook_pages.empty?
        render json: {
          errors: 'The user does not have any pages yet. Please create one.',
          status: 400
        }
      else
        render json: current_user.facebook_pages
      end
    end
  end
end
