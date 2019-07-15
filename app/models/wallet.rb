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
  
  def audit(m_name, amount)
    transaction_records.create(type: m_name, amount: amount)
  end

  # METHODS
  # ------------------------------

  def fund(amount, card_number)
    card = credit_cards.find_by card_number: card_number
    
    if card.has_funds?(amount)
      update_attributes balance: (balance + amount)
      audit(__method__, amount)
    end
  end

  def receive(amount)
    update_attributes balance: (balance + amount)
  end

  def transfer(amount, receiver)
    if has_funds?(amount)
      receiver.receive amount
      update_attributes balance: (balance - amount)
      audit(__method__, amount)
    end
  end

  def has_funds?(amount = 0)
    amount > 0 && balance > 0 && balance > amount
  end
end
