class User < ApplicationRecord 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true, uniqueness: true
  validates :phone_number, presence: true, length: { minimum: 11, maximum:11}
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :referrer_code, presence: true, if: :referrer_code_present?
  validate :valid_referrer_code, if: :referrer_code_present?

  #This handles the User Plan Functionality
  belongs_to :plan, optional: true
  
  #This sets every new user on Basic Plan.
  before_validation :set_default_plan, on: :create

  

  #This handles the user referral management system
  has_many :referrals, class_name: 'User', foreign_key: 'referrer_id'
  belongs_to :referrer, class_name: 'User', optional: true
  
  #This handles the user-referral association method
  after_create :associate_referrer

  after_create :add_balance_for_referrer
  
  #This handles setting referral code to user's username once user is signed up
  before_create :generate_referral_code

  #This handles setting the initial user wallet balance to 0 upon registration.
  after_create :set_initial_wallet_balance

  #This handles user session logout after 2minutes.
  def timeout_in
    120.seconds
  end
  

  private

  #This handles setting  new_user on basic plan by default at sign up
  def set_default_plan
    self.plan ||= Plan.find_by(name: 'Basic')
  end

  #This handles setting referral code to user's username once user is signed up
  def generate_referral_code
    self.referral_code = username
  end
  
  #This handles setting the initial user wallet balance to 0 upon registration.
  def set_initial_wallet_balance
    update(balance: 0)
  end

  #This handles the checking for the presence of referrer_code for new registations
  def referrer_code_present?
    referrer_code.present?
  end
  
  
  #This handles the checking of the validity of referral_code, to be sure the code exists.
  def valid_referrer_code
    referred_by_user = User.find_by(username: referrer_code)
    errors.add(:referrer_code, "is invalid") unless referred_by_user
  end

 
 #This handles the association of referrer_code and referrer_id  to a new user.
  def associate_referrer
    return unless referrer_code.present?

    referrer = User.find_by(username: referrer_code)
    self.referrer = referrer if referrer
    self.referrer_id = referrer.id if referrer
    save
  end


  #This handles the referrer reward which gives a referrer NGN 100 IF referrals are up 5.
  def add_balance_for_referrer
    return unless referrer

    if referrer.referrals.count == 5
      referrer.update(balance: referrer.balance + 100)
    end
  end





end