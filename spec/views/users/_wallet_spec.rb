require 'rails_helper'

describe "users/_wallet" do
  let(:wallet)  { create :wallet }

  context "when can read user wallet" do
    before                                { allow_any_instance_of(Ability).to receive(:can?).and_return(true) }
    before                                { render partial: "users/wallet", locals: { wallet: wallet } }
    it("displays wallet balance")         { expect(rendered).to have_selector "b#balance", text: wallet.balance }
    it("displays wallet id")              { expect(rendered).to have_selector "b#id", text: wallet.id }   
  end

  context "when cannot read user wallet" do
    before                                { allow_any_instance_of(Ability).to receive(:can?).and_return(false) }
    before                                { render partial: "users/wallet", locals: { wallet: wallet } }
    it("doens't display wallet balance")  { expect(rendered).not_to have_selector "p.wallet" }
  end
end