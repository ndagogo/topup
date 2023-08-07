class AddReferringUserIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :referral_user_id, :bigint     
  end
end
