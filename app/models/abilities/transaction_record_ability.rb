module Abilities
  class TransactionRecordAbility
    include CanCan::Ability

    def initialize(user)
      can(:read, TransactionRecord, wallet_id: user.wallet.id) if user.present?
    end
  end
end