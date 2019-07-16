module Abilities
  class CreditCardAbility
    include CanCan::Ability

    def initialize(user)
      can %i[fund create read update destroy], CreditCard, wallet_id: user.wallet.id if user.present?
    end
  end
end