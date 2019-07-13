class CreditCard < ApplicationRecord
  include Askable

  # ASSOCIATIONS
  # --------------------------------
  
  belongs_to :wallet
  delegate :user, to: :wallet, allow_nil: true

  # VALIDATIONS
  # --------------------------------
  NETWORKS = %w(visa mastercard american_express)
  
  validates :network, presence: true, inclusion: { in: NETWORKS, message: "is not supported" }
  validates :card_number, presence: true
  validates :expiration_date, presence: true, format: { with: expire_date_regex }
  validates_uniqueness_of :card_number
  validates_format_of :card_number, with: visa_regex, if: :visa?
  validates_format_of :card_number, with: mastercard_regex, if: :mastercard?
  validates_format_of :card_number, with: amex_regex, if: :american_express?

  # BOOLEANS
  # --------------------------------
  
  set_askers %i(visa mastercard american_express)
  
end
