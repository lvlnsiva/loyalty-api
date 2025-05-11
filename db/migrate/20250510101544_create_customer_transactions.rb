class CreateCustomerTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :customer_transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount
      t.string :currency
      t.string :country
      t.datetime :transaction_date

      t.timestamps
    end
  end
end
