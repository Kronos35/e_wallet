class Wallet < ApplicationRecord
  def self.build_default(user)
    Wallet.new(user: user)
  end

  belongs_to :user
end
