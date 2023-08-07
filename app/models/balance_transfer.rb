class BalanceTransfer < ApplicationRecord
  validates :receiver_username, presence: true
  validates :amount, presence: true
  validates :description, presence: true
  
  # include ActiveModel::Model
  
  #   attr_accessor :receiver_username, :amount, :description
end
  