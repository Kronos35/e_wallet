require 'rails_helper'

describe UsersController, "#show" do
  let(:user)  { create :user }
  subject     { response }

  context "when user signed in" do
    before { sign_in user }
    
    it("is successful") do 
      get :show, params: { id: user.id }
      expect(response).to be_successful 
    end
    
    it("finds user") do 
      expect(User).to receive(:find).and_return(user)
      get :show, params: { id: user.id }
    end
  end

  context "when no user signed in" do
    before { get :show, params: { id: user.id } }
    it("redirects to login page") { expect(response).to redirect_to new_user_session_path }
  end
end

describe UsersController, "#edit" do
  let(:peter_parker)  { create :peter_parker }
  let(:reed_richards) { create :reed_richards  }

  context "when signed in user" do
    before  { sign_in peter_parker }

    context "edits itself" do
      before              { get :edit, params: { id: peter_parker.id } }
      it("is successful") { expect(response).to be_succesful }
    end

    context "tries to edit other user" do
      before  { get :edit, params: { id: reed_richards.id } }
      it("redirects to user's own profile") { expect(response).to redirect_to new_user_session_path }
    end
  end

  context "when no user signed in" do
    it("redirects to login page") { expect(response).to redirect_to  }
  end
end

context UsersController, "#update" do
  context "when signed in user" do
    context "updates itself" do
      it("updates user")
      it("redirects to user's own profile")
    end
    context "tries to update somebody else" do
      it("redirects to user's profile")
    end
  end
end
