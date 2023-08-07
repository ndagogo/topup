class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: true
  validates :phone_number, presence: true, length: { minimum: 11, maximum:11} 

  #This handles setting the initial Admin wallet balance to 1000 upon registration.
  after_create :set_initial_wallet_balance
 
  
  private

  #This handles setting the initial Admin wallet balance to 1000 upon registration.
  def set_initial_wallet_balance
    update(balance: 1000)
  end

end
