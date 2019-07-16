module Abilities
  class WalletAbility
    include CanCan::Ability

    def initialize(user)
      can %i[read update destroy], Wallet, id: user.wallet.id if user.present?
    end
  end
end