module Benefits
  class RewardsController < ApplicationController
    def index
      render json: @current_user.rewards.order(issued_at: :desc)
    end
  end
end
