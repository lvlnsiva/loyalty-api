module Accounts
  class UsersController < ApplicationController
    skip_before_action :authenticate_api_key!, only: [:create, :show]
    def show
      render json: @current_user
    end

    def create
      user = User.create!(user_params)
      render_success(user, message: 'Success', code: 200, status: :created)
    rescue ActiveRecord::RecordInvalid => e
      render_error(422, code: 422, error_message: e.message)
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :date_of_birth)
    end
  end
end
