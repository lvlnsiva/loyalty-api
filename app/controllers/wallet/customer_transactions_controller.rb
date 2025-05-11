module Wallet
  class CustomerTransactionsController < ApplicationController
    def create
      transaction = nil

      ActiveRecord::Base.transaction do
        transaction = @current_user.customer_transactions.create!(transaction_params)

        Loyalty::PointCalculator.new(transaction).call
        Loyalty::RewardEvaluator.new(@current_user).evaluate!

        raise ActiveRecord::Rollback if transaction.point.nil?
      end

      render json: {
        code: 200,
        message: 'Transaction successful',
        transaction: transaction,
        points_awarded: transaction.point&.points
      }, status: :ok
    rescue ActiveRecord::RecordInvalid => e
      render json: { 
        code: 500, 
        error: e.message, 
        message: "Validation failed" 
      }, status: :unprocessable_entity
    rescue ActiveRecord::Rollback
      render json: { 
        code: 500, 
        error: "Transaction failed, point creation failed.",
        message: "Transaction and point creation rolled back"
      }, status: :unprocessable_entity
    rescue StandardError => e
      render json: {
        code: 500,
        error: e.message,
        message: "Internal server error"
      }, status: :internal_server_error
    end

    private

    def transaction_params
      params.require(:transaction).permit(:amount, :currency, :country, :transaction_date)
    end
  end
end
