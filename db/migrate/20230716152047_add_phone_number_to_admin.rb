class AddPhoneNumberToAdmin < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :phone_number, :string
  end
end
