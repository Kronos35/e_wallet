class CreditCard < ApplicationRecord
  attr_encrypted :card_number, key: Rails.application.credentials.key

  include Askable

  # ASSOCIATIONS
  # --------------------------------

  belongs_to :wallet
  delegate :user, to: :wallet, allow_nil: true

  # VALIDATIONS
  # --------------------------------

  def self.brands
    %w(visa mastercard american_express)
  end
  
  validates :year,  presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 9999 } 
  validates :month, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 12 } 
  validates :brand, presence: true, inclusion: { in: CreditCard.brands, message: "is not supported" }
  validates :card_number, presence: true, uniqueness: true
  validates_format_of :card_number, with: visa_regex, if: :visa?
  validates_format_of :card_number, with: mastercard_regex, if: :mastercard?
  validates_format_of :card_number, with: amex_regex, if: :american_express?

  # BOOLEANS
  # --------------------------------

  set_askers %i(visa mastercard american_express)

  def has_funds?(amount)
    true
  end
end