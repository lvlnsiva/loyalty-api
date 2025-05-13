module Loyalty
  class UserLevelEvaluator
    LEVEL_2_THRESHOLD = 1000

    def initialize(user)
      @user = user
    end

    def evaluate!
      total_spent = @user.customer_transactions&.sum(:amount)

      if total_spent > LEVEL_2_THRESHOLD
        @user.update!(level: :level_2)
      else
        @user.update!(level: :level_1)
      end
    end
  end
end
