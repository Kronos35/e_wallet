module CreditCardsHelper
  def card_attrs
    params.require(:credit_card).permit %i(card_number brand year month)
  end

  alias_method :update_params, :card_attrs
  alias_method :create_params, :card_attrs
end
