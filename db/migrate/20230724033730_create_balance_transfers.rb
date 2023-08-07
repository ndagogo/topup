class CreateBalanceTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :balance_transfers do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.decimal :amount
      t.text :description

      t.timestamps
    end
  end
end
