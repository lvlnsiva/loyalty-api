module Accounts
  class UsersController < ApplicationController
    def show
      render json: @current_user
    end

    def create
      user = User.create!(user_params)
      render json: user, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
  end
end
