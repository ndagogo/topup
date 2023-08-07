class AddReferrerCodeToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :referrer_code, :string
    add_index :users, :referrer_code
  end
end
