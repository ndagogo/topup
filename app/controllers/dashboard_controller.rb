class DashboardController < ApplicationController
  before_action :authenticate_admin!, only: [:admin]
  before_action :authenticate_user!, only: [:user]
 
  def user 
   
  end

  def admin
    
  end

 
end
