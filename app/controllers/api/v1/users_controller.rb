module Api::V1
  class UsersController < ApiController
    before_action :authenticate_user!

    def index
      render json: User.all
    end

    def show
      render json: User.find(params[:id])
    end

    def current
      render json: current_user
    end
  end
end
