module Loyalty
  class RewardEvaluator
    def initialize(user)
      @user = user
    end

    def evaluate!
      return unless @user.persisted?

      if @user.level == "level_1"
        monthly_points = @user.points
          .where("strftime('%m', created_at) = ?", Date.today.strftime('%m'))
          .sum(:points)

        issue("Free Coffee") if monthly_points >= 100
      end

      if @user.level == "level_2"
        issue("Free Coffee") if Date.today.month == @user.date_of_birth.month

        first_tx = @user.customer_transactions.order(:transaction_date).first
        return unless first_tx

        if Date.today <= first_tx.transaction_date + 60.days &&
           @user.customer_transactions.where("transaction_date <= ?", Date.today).sum(:amount) > 1000
          issue("Free Movie Ticket")
        end
      end
    end

    private

    def issue(type)
      @user.rewards.find_or_create_by!(reward_type: type, issued_at: Time.current)
    end
  end
end
