class Wallet < ApplicationRecord
  def self.build_default(user)
    Wallet.new(user: user)
  end

  # ASSOCIATIONS
  # ------------------------------
  
  belongs_to  :user
  has_many    :credit_cards

  # VALIDATIONS
  # ------------------------------

  CURRENCIES = %w(mxn usd aud eur)

  validates :currency_type, presence: true, inclusion: { in: CURRENCIES, message: "is not supported" }

end
