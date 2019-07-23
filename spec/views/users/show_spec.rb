require "rails_helper"

describe "users/show" do
  let(:user)  { create :user } 
  before      { assign(:user, user) }

  context "when can read user wallet" do
    before                                { allow_any_instance_of(Ability).to receive(:can?).and_return(true) }
    before                                { render }
    it("displays user's name")            { expect(rendered).to have_selector "h1", text: user.name }
    it("displays user's email")           { expect(rendered).to have_selector "b", text: user.email }
    it("displays user's balance")         { expect(rendered).to have_selector "p.balance" }
  end

  context "when cannot read user wallet" do
    before                                { allow_any_instance_of(Ability).to receive(:can?).and_return(false) }
    before                                { render }
    it("displays user's name")            { expect(rendered).to have_selector "h1", text: user.name }
    it("displays user's email")           { expect(rendered).to have_selector "b", text: user.email }
    it("doens't display user's balance")  { expect(rendered).not_to have_selector "p.balance" }
  end
end
