class CreateRewards < ActiveRecord::Migration[7.2]
  def change
    create_table :rewards do |t|
      t.references :user, null: false, foreign_key: true
      t.string :reward_type
      t.datetime :issued_at

      t.timestamps
    end
  end
end
