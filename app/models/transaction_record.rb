class TransactionRecord < ApplicationRecord
  self.inheritance_column = :foo
  
  # Associations
  # ----------------------------
  
  belongs_to :wallet

  # Validations
  # ----------------------------

  validates :type, presence: true, inclusion: {in: %w(transfer fund withdrawal), message: "is not valid" }
  validates :description, presence: true
  validates :amount, presence: false, numericality: { if: :amount? }

  before_validation :describe, if: :type?

  def describe
    self.description ||= I18n.t "transfer_records.descriptions.#{type}"
  end
end
