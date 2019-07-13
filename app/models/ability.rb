# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, User
    can :edit, User, id: user&.id
    can :update, User, id: user&.id
  end
end
