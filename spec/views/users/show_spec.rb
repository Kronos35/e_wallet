require "rails_helper"

describe "users/show" do
  let(:user)  { create :user }
  before      { assign(:user, user) }
  before      { render }
  
  it("displays user's name")  { expect(rendered).to have_selector "h1", text: user.name }
  it("displays user's email") { expect(rendered).to have_selector "b", text: user.email }
end
