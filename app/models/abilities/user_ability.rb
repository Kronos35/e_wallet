module Abilities
  class UserAbility
    include CanCan::Ability

    def initialize(user)
      if user.present?
        can :read, User
        can %i(update destroy), User, id: user&.id
      end
    end
  end
end