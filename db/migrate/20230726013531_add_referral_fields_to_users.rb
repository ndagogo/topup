class AddReferralFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :referrer_id, :integer
    add_index :users, :referrer_id
  end
end
