class AddPlanToUsers < ActiveRecord::Migration[7.0]
  def change
    #add_reference :users, :plan, null: false, foreign_key: true
    add_reference :users, :plan, foreign_key: true, null: true
  end
  
end
