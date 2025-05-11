module Loyalty
  class PointCalculator
    def initialize(transaction)
      @transaction = transaction
      @user = transaction.user
    end

    def call
      base = (@transaction.amount / 100).floor * 10
      multiplier = (@user.level == "level_2" && foreign?) ? 2 : 1
      points = base * multiplier

      return if points.zero?

      Point.create!(
        user: @user,
        customer_transaction: @transaction,
        points: points,
        reason: 'transaction'
      )
    end

    private

    def foreign?
      @transaction.country.downcase != "singapore"
    end
  end
end
