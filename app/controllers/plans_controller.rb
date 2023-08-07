class PlansController < ApplicationController
    def index
      @plans = Plan.all
    end
  
    def upgrade
      new_plan = Plan.find(params[:plan_id])
      user = current_user
  
      if new_plan != user.plan && new_plan.name != 'Basic' && user.balance >= new_plan.fee
        # Deduct new_plan.fee from current_user's balance
        user.balance -= new_plan.fee
  
        # Check if current_user has a referrer and update their balance
        if user.referrer && user.referrer.plan.typ == 1
           user.referrer.balance += (user.plan.fee * 0.2)
           user.referrer.save
        end
  
        #user.previous_plan = user.plan
        user.plan = new_plan
        user.save
  
        redirect_to dashboard_user_path 
        flash[:notice] = "Plan upgraded successfully to #{ new_plan.name } Plan."
      else
        redirect_to dashboard_user_path, alert: 'Unable to upgrade plan. Check Your Wallet Balance ! '
      end
    end
end
  