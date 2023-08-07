class DropTransfers < ActiveRecord::Migration[7.0]
  def change
    drop_table :transfers
  end
end
