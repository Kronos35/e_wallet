require 'rails_helper'

describe CreditCardsController, "#index" do
  let(:user)  { create :user }
  let(:index_request) { get :index }
  
  context "when signed in" do
    before                          { sign_in user }
    it("returns http success")      { index_request; expect(response).to have_http_status(:success) }
    it("finds users' credit cards") { expect_any_instance_of(User).to receive(:credit_cards); index_request }
  end

  context "when not signed in" do
    it("redirects to login page")   { index_request; expect(response).to redirect_to new_user_session_path }
  end
end

describe CreditCardsController, "#new" do
  let(:user)                      { create :user } 
  before                          { sign_in user }
  before                          { get :new }
  it("returns http success")      { expect(response).to have_http_status(:success) }
end

describe CreditCardsController, "#edit" do
  context "when owner user is signed_in" do
    let(:user)                    { create :user }
    let!(:credit_card)            { create :credit_card, wallet: user.wallet } 
    before                        { sign_in user }
    before                        { get :edit, params: { id: credit_card.id } }
    it("returns http success")    { expect(response).to have_http_status(:success) }
  end

  context "when foreign user is signed_in" do
    let(:user)                    { create :tony_stark }
    let!(:credit_card)            { create :credit_card } 
    before                        { sign_in user }
    let(:request)                 { get :edit, params: { id: credit_card.id } }
    it("denies access to user")   { expect{ request }.to raise_error CanCan::AccessDenied }
  end
end

describe CreditCardsController, "#create" do
  let(:user)                    { create :user }
  let(:attributes)              { attributes_for :credit_card, wallet: user.wallet }
  let(:creation_request)        { post :create, params: { credit_card: attributes } }
  before                        { sign_in user }
  it("returns http success")    { creation_request; expect(response).to redirect_to(credit_cards_path) }
  it("creates new credit_card") { expect { creation_request }.to change{ CreditCard.count } }
end

describe CreditCardsController, "#update" do
  let(:user)            { create :user }
  let(:attributes)      { attributes_for :credit_card, :mastercard, wallet: nil }
  let(:update_request)  { patch :update, params: { id: credit_card.id, credit_card: attributes } }
  before                { sign_in user }
  
  context "when owner is signed in" do
    let(:credit_card)                     { create :credit_card, :visa, wallet: user.wallet }
    it("returns http success")            { update_request; expect(response).to redirect_to(credit_cards_path) }
    it("updates credit card attributes")  { expect{ update_request }.to change { [credit_card.reload.card_number,credit_card.reload.brand] } }
  end

  context "when foreign user is signed_in" do
    let(:credit_card)                     { create :credit_card, :visa, wallet: create(:tony_stark).wallet }
    before                                { sign_in user }
    it("denies access to user")           { expect{ update_request }.to raise_error CanCan::AccessDenied }
  end
end

describe CreditCardsController, "#destroy" do
  let!(:user)           { create :user }
  let(:delete_request)  { delete :destroy, params: { id: credit_card.id } }


  context "when owner is signed in" do
    let!(:credit_card)    { create :credit_card, :visa, wallet: user.wallet }
    before                { sign_in user }

    it("returns http success")    { delete_request; expect(response).to redirect_to(credit_cards_path) }
    it("it deletes credit_card")  { expect{ delete_request }.to change{ CreditCard.count }.by(-1) }
  end
  
  context "when foreign user is signed_in" do
    let(:credit_card)             { create :credit_card, :visa, wallet: create(:tony_stark).wallet }
    before                        { sign_in user }
    it("denies access to user")   { expect{ delete_request }.to raise_error CanCan::AccessDenied }
  end
end
