class RenameTypeColumnInPlans < ActiveRecord::Migration[7.0]
  def change
    rename_column :plans, :type, :typ
  
  end
end
