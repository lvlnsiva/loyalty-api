module Benefits
  class RewardsController < ApplicationController
    def index
      user = User.find_by(id: params[:user_id])
      return render_error(404, code: 404, error_message: "User not found") unless user
      return render_error(404, code: 404, error_message: "User rewards not found") unless user.rewards.present?

      rewards = user.rewards.order(issued_at: :desc)
      render_success(rewards, message: "Rewards fetched successfully", code: 200, status: :ok)
    end
  end
end