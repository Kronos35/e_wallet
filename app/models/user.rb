class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # VALIDATIONS
  # --------------------------
  
  validates :name, presence: true

  # ASSOCIATIONS
  # --------------------------
  
  has_one :wallet
  has_many :credit_cards, through: :wallet
  
  def wallet
    super.present? ? super : Wallet.build_default(self)
  end

  # DELEGATIONS
  # --------------------------
  
  delegate :balance, to: :wallet
  delegate :balance=, to: :wallet
  delegate :can?, to: :ability

  # CALLBACKS
  # --------------------------
  
  after_save :save_wallet

  def save_wallet
    wallet.save
  end

  def ability
    Ability.new self
  end
end
