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
      let(:controller_request)  { get :edit, params: { id: peter_parker.id } }
      it("is successful")       { controller_request; expect(response).to be_successful }
      it("finds user")          { expect(User).to receive(:find).and_return(peter_parker); controller_request }
    end

    context "tries to edit other user" do
      let(:controller_request)        { get :edit, params: { id: reed_richards.id } }
      it("raises AccessDenied error") { expect{ controller_request }.to raise_error{ CanCan::AccessDenied } }
    end
  end

  context "when no user signed in" do
    before  { get :edit, params: { id: reed_richards.id } } 
    it("redirects to login page") { expect(response).to redirect_to new_user_session_path }
  end
end

context UsersController, "#update" do
  let(:peter_parker)      { create :peter_parker }
  let(:reed_richards)     { create :reed_richards }
  let(:valid_attributes)  { attributes_for :tony_stark }
  let(:invalid_attributes){ attributes_for :invalid_user }

  context "when signed in user" do
    before                { sign_in peter_parker }

    context "updates itself with valid arguments" do
      let(:controller_request)      { post :update, params: { id: peter_parker.id, user: valid_attributes } }
      it("updates user")            { expect { controller_request }.to change { peter_parker.reload.name } }
      it("redirects to login page") { controller_request; expect(response).to redirect_to user_path peter_parker}
    end

    context "updates itself with invalid arguments" do
      let(:controller_request)              { post :update, params: { id: peter_parker.id, user: invalid_attributes } }
      it("doesn't update user")             { expect{ controller_request }.not_to change{ peter_parker.reload.name } }
    end

    context "tries to update somebody else" do
      let(:controller_request)              { post :update, params: { id: reed_richards.id, user: valid_attributes } }
      it("doesn't change other user")       { expect{ subject }.not_to change{ reed_richards } }
      it("raises AccessDenied error")       { expect{ controller_request }.to raise_error{ CanCan::AccessDenied } }
    end
  end
end
