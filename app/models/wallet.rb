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
  has_many    :transaction_records

  # VALIDATIONS
  # ------------------------------

  validates :currency_type, presence: true, inclusion: { in: Wallet.CURRENCIES, message: "is not supported" }

  # CALLBACKS
  # ------------------------------
  
  def audit(method_name, amount)
    record = transaction_records.new
    record.type = method_name
  end

  # METHODS
  # ------------------------------

  def fund(amount, card_number)
    card = credit_cards.find_by card_number: card_number
    
    if card.has_funds?(amount)
      update_attributes balance: (balance + amount)
    end
  end
end
