require 'rails_helper'

describe User do
  context "when valid" do
    subject { create :user }
    before  { is_expected.to be_valid }

    it("has name")        { expect(subject.name).to be_present }
    it("has email")       { expect(subject.email).to be_present }
    it("has balance = 0") { expect(subject.balance).to eq 0 }
  end

  context "when invalid" do
    subject { User.new }
    before  { is_expected.to be_invalid }

    it("has dafault balance = 0")           { expect(subject.balance).to eq 0 }
    it("has name 'can't be blank' error")   { expect(subject.errors[:name]).to include 'can\'t be blank' }
    it("has email 'can't be blank' error")  { expect(subject.errors[:email]).to include 'can\'t be blank' }
  end 
end

describe User, "#wallet" do
  subject     { user.wallet }

  context "when new user" do
    let!(:user) { User.new }
    it("has a default wallet") do 
      is_expected.to be_present
      is_expected.to be_a Wallet
      is_expected.to be_new_record
    end
  end

  context "when persited" do
    let!(:user) { create :user }
    it("has a persisted wallet") do
      is_expected.to be_present
      is_expected.to be_a Wallet
      is_expected.to be_persisted
    end
  end
end

describe User, "#save" do
  subject     { travel_to(Time.now + 1.minute){ user.save }}

  context "when new_record? = true" do
    let!(:user)  { build :user }
    it("creates a new wallet associated with user") { expect{ subject }.to change{ Wallet.count }.by(1)  }
  end

  context "when persisted? = true" do
    let!(:user) { create :user }

    it("has associated wallet")         { expect(user.wallet).to be_present }
    it("doesn't create new wallet")     { expect{ subject }.not_to change{ Wallet.count } }

    context "and wallet changed" do
      let!(:wallet)                     { user.wallet }
      before                            { wallet.balance = 2 }
      it("updates persisted wallet")    { expect{ subject }.to change{ user.wallet.updated_at } }
    end
  end
end

describe User, "#credit_cards" do
  let!(:user) { create :user }
  subject     { user.credit_cards }

  context "when user is associated with credit_cards" do
    let!(:credit_card)  { create :credit_card, wallet: user.wallet }

    it("returns a collection of credit_cards")      { is_expected.to all be_a CreditCard }
    it("returns credit_cards associated with user") { is_expected.to eq [ credit_card ] }
  end

  context "when user is NOT associated with credit_cards" do
    it("returns an empty array/colletion")          { is_expected.to be_empty}
  end
end
