class CreditCardsController < ApplicationController
  respond_to :html, :json
  after_action :respond_to_index, only: %i(create update destroy)
  load_and_authorize_resource
  include CreditCardsHelper

  def index
    @credit_cards = current_user.credit_cards
  end

  def new
    @credit_card = credit_cards.new
  end

  def edit
    @credit_card = current_credit_card
  end

  def create
    @credit_card = credit_cards.new(card_attrs)
    @credit_card.save
    respond_with(@credit_card, location: credit_cards_path)
  end

  def update
    @credit_card = current_credit_card.update_attributes(card_attrs)
    respond_with(@credit_card, location: credit_cards_path)
  end

  def destroy
    @credit_card = current_credit_card
    @credit_card.destroy
    respond_with(@credit_card, location: credit_cards_path)
  end

  private

  delegate :wallet, to: :current_user
  delegate :credit_cards, to: :wallet

  def respond_to_index
    
  end

  def current_credit_card
    credit_cards.find(params[:id])
  end
end
