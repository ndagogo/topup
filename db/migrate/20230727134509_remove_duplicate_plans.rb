class RemoveDuplicatePlans < ActiveRecord::Migration[7.0]
  def up
    # Find the duplicates based on name, plan_type, and fee
    duplicate_plans = Plan.group(:name, :typ, :fee).having('COUNT(*) > 2')

    # Loop through each duplicate plan group
    duplicate_plans.each do |plan_group|
      # Get all the duplicate plans in the group
      duplicate_plans_in_group = Plan.where(name: plan_group.name, typ: plan_group.typ, fee: plan_group.fee)

      # Keep the first plan and delete the rest
      first_plan = true
      duplicate_plans_in_group.each do |plan|
        if first_plan
          first_plan = false
        else
          plan.destroy
        end
      end
    end
  end

  def down
    # This migration cannot be reversed
  end
end
