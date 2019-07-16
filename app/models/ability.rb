class Ability
  include CanCan::Ability

  RESOURCES=%i(user wallet credit_card transaction_record)

  def initialize(user)
    RESOURCES.each do |resource|
      ability_class = "abilities/#{resource}_ability".classify.safe_constantize
      merge(ability_class.new(user)) if ability_class
    end
  end
end
