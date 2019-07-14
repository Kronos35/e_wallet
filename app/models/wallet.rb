class Wallet < ApplicationRecord
  # CLASS_METHODS
  # ------------------------------
  
  def self.build_default(user)
    Wallet.new(user: user)
  end

  def self.CURRENCIES
    %w(usd mxn aud eur)
  end

  # ASSOCIATIONS
  # ------------------------------
  
  belongs_to  :user
  has_many    :credit_cards

  # VALIDATIONS
  # ------------------------------

  validates :currency_type, presence: true, inclusion: { in: Wallet.CURRENCIES, message: "is not supported" }

  # Methods

  def exchange(new_curr)
    
  end

end
