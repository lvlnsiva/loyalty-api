class Point < ApplicationRecord
  belongs_to :user
  belongs_to :customer_transaction
end
