module Wallet
  class CustomerTransactionsController < ApplicationController
    before_action :authorize_user!
    def create
      transaction = nil

      ActiveRecord::Base.transaction do
        transaction = @current_user.customer_transactions.create!(transaction_params)
        
        Loyalty::PointCalculator.new(transaction).call
        Loyalty::UserLevelEvaluator.new(@current_user).evaluate!
        Loyalty::RewardEvaluator.new(@current_user).evaluate!

        raise ActiveRecord::Rollback if transaction.point.nil?
      end

      render_success({transaction: transaction, points_awarded: transaction.point&.points}, code: 200, message: 'Transaction successful', status: :ok)
    rescue ActiveRecord::RecordInvalid => e
      render_error(422, code: 422, error_message: e.message)
    rescue ActiveRecord::Rollback
      render_error(422, code: 422, error_message: "Transaction failed, point creation failed.")
    rescue StandardError => e
      render_error(500, code: 500, error_message: e.message)
    end

    private

    def transaction_params
      params.require(:transaction).permit(:amount, :currency, :country, :transaction_date)
    end

    def authorize_user!
      user = User.find_by(id: params[:user_id])
      return render_error(404, code: 404, error_message: "User not found") unless user
      return render_error(403, code: 403, error_message: "Forbidden: User mismatch") if user.id != @current_user.id
    end

    # def render_success(transaction)
    #   render json: {
    #     code: 200,
    #     message: 'Transaction successful',
    #     transaction: transaction,
    #     points_awarded: transaction.point&.points
    #   }, status: :ok
    # end

    # def render_error(http_status, code:, error_message:)
    #   render json: {
    #     code: code,
    #     error_message: error_message,
    #   }, status: http_status
    # end
  end
end
