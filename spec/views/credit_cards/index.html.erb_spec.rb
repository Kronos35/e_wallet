require 'rails_helper'

describe "credit_cards/index.html.erb" do
  let!(:user)  { create :user }

  context "with credit_cards" do
    let!(:visa_card)    { create(:credit_card, :visa, wallet: user.wallet) }
    let!(:master_card)  { create(:credit_card, :mastercard, wallet: user.wallet) }
    
    before { assign :credit_cards, user.credit_cards }
    before { render template: "credit_cards/index.html.erb", locals: { current_user: user } }
    
    it("displays credit_cards' table")  { expect(rendered).to have_selector "table#credit_cards" }
    it("displays new credit_card link") { expect(rendered).to have_selector "a", text: "Add credit card" } 
    
    it("displays credit_cards") do
      expect(rendered).to have_selector "table#credit_cards tbody tr##{visa_card.id}"
      expect(rendered).to have_selector "table#credit_cards tbody tr##{master_card.id}"
    end

    it("displays credit_card numbers") do
      expect(rendered).to have_selector "table#credit_cards tbody tr##{visa_card.id} td", text: visa_card.card_number
      expect(rendered).to have_selector "table#credit_cards tbody tr##{master_card.id} td", text: master_card.card_number
    end

    it("displays credit_card brands") do
      expect(rendered).to have_selector "table#credit_cards tbody tr##{visa_card.id} td", text: visa_card.brand
      expect(rendered).to have_selector "table#credit_cards tbody tr##{master_card.id} td", text: master_card.brand
    end
    
    it("displays edit credit_card links") do
      expect(rendered).to have_selector "table#credit_cards tbody tr##{visa_card.id} a", text: 'Edit'
      expect(rendered).to have_selector "table#credit_cards tbody tr##{master_card.id} a", text: 'Edit'
    end

    it("displays delete credit_card links") do
      expect(rendered).to have_selector "table#credit_cards tbody tr##{visa_card.id} a", text: 'Delete'
      expect(rendered).to have_selector "table#credit_cards tbody tr##{master_card.id} a", text: 'Delete'
    end
  end
end
