class BalanceTransfersController < ApplicationController
    before_action :authenticate_user!

    def new
      @balance_transfer = BalanceTransfer.new
    end
  
    def create
      sender = current_user
      receiver = User.find_by(username: balance_transfer_params[:receiver_username])
      amount = balance_transfer_params[:amount].to_f
  
      if receiver.nil?
        flash[:alert] = "Receiver not found."
        redirect_to new_balance_transfer_path
        return
      end

      if receiver == sender
        flash[:alert] = "PROHIBITED ACTION!."
        redirect_to new_balance_transfer_path
        return
      end
  
      if sender.balance < amount 
        flash[:alert] = "Insufficient balance to transfer."
        redirect_to new_balance_transfer_path
        return
      end


      if amount < 1
        flash[:alert] = "You cannot transfer this amount!"
        redirect_to new_balance_transfer_path
        return
      end
  
      sender.balance -= amount
      receiver.balance += amount
  
      if sender.save && receiver.save
        flash[:notice] = "Congratulations! You have transferred NGN #{amount} to #{receiver.username}. Transaction was successful."
        redirect_to dashboard_user_path
      else
        flash[:alert] = "An error occurred while processing the transfer."
        redirect_to new_balance_transfer_path
      end
    end
  
    private
  
    def balance_transfer_params
      params.require(:balance_transfer).permit(:receiver_username, :amount, :description)
    end
end
  