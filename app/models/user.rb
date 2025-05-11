class User < ApplicationRecord
  has_many :customer_transactions
  has_many :points
  has_many :rewards

  enum level: { level_1: 0, level_2: 1 }

  before_create :generate_api_key

  def generate_api_key
    self.api_key = SecureRandom.hex(20)
  end
end
