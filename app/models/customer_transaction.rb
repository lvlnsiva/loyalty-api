class CustomerTransaction < ApplicationRecord
  belongs_to :user
  has_one :point, dependent: :destroy

  validate :transaction_date_cannot_be_in_the_past

  private

  def transaction_date_cannot_be_in_the_past
    if transaction_date.present? && transaction_date < Date.today
      errors.add(:transaction_date, "cannot be in the past")
    end
  end
end
