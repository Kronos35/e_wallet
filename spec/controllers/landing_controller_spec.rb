require 'rails_helper'

describe LandingController, "#home" do
  let(:user)  { create :user }
  context "when logged in" do
    before { sign_in user }
    before { get :home }
    it("is successful") { expect(response).to be_successful }
  end

  context "when not logged in" do
    before { get :home }
    it("redirects to login page") { expect(response).to redirect_to new_user_session_path }
  end
end
