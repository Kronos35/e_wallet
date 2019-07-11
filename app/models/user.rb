class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # VALIDATIONS
  # --------------------------
  
  validates :name, presence: true

  # ASSOCIATIONS
  # --------------------------
  
  has_one :wallet
  has_many :credit_cards
  
  def wallet
    super.present? ? super : Wallet.build_default(self)
  end

  # DELEGATIONS
  # --------------------------
  
  delegate :balance, to: :wallet
  delegate :balance=, to: :wallet

  # CALLBACKS
  # --------------------------
  
  after_save :save_wallet

  def save_wallet
    wallet.save
  end
end
