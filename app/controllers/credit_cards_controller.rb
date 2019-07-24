class CreditCardsController < ApplicationController
  load_and_authorize_resource
  
  respond_to    :html, :json
  before_action :find_current_credit_card, only: %i(edit update destroy)
  
  include CreditCardsHelper

  def index
    @credit_cards = current_user.credit_cards
  end

  def new
    @credit_card = credit_cards.new
  end

  def edit
  end

  def create
    @credit_card = credit_cards.new(card_attrs)
    if @credit_card.save
      respond_with(@credit_card, location: credit_cards_path)
    else
      respond_with(@credit_card, status: :bad_request)
    end
  end

  def update
    if @credit_card.update_attributes(card_attrs)
      respond_with(@credit_card, location: credit_cards_path)
    else
      respond_with(@credit_card, status: :bad_request)
    end
  end

  def destroy
    @credit_card.destroy
    respond_with(@credit_card, location: credit_cards_path)
  end

  private

  delegate :wallet, to: :current_user
  delegate :credit_cards, to: :wallet

  def find_current_credit_card
    @credit_card = credit_cards.find(params[:id])
  end
end
