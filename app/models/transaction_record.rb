class TransactionRecord < ApplicationRecord
  self.inheritance_column = :foo
  belongs_to :wallet
end
