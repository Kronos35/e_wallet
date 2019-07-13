require 'rails_helper'

describe CreditCard do
  context "when valid" do
    subject                   { build :credit_card }
    before                    { is_expected.to be_valid }
    it("has network")         { expect(subject.network).to be_present }
    it("has Card number")     { expect(subject.card_number).to be_present }
    it("has expiration date") { expect(subject.expiration_date).to be_present }

    %i(visa mastercard american_express).each do |network|
      context "when network = #{network}" do
        subject         { build :credit_card, network }
        it("is valid")  { is_expected.to be_valid }
      end
    end
  end

  context "when invalid" do
    context "with blank attributes" do 
      subject                                           { CreditCard.new }
      before                                            { is_expected.to be_invalid }
      it("has Wallet 'must exist error'")               { expect(subject.errors[:wallet]).to include "must exist" }
      it("has Card number 'can't be blank' error")      { expect(subject.errors[:card_number]).to include "can't be blank" }
      it("has Expiration date 'can't be blank' error")  { expect(subject.errors[:expiration_date]).to include "can't be blank" }
    end

    context "with invalid attributes" do 
      %w(visa mastercard american_express).each do |network|
        context "when network = #{network}" do
          subject                                       { build(:invalid_card, :invalid_attribs, network: 'visa') }
          before                                        { is_expected.to be_invalid }
          it("has Card number 'is invalid' error")      { expect(subject.errors[:card_number]).to include "is invalid" }
          it("has Expiration date 'is invalid' error")  { expect(subject.errors[:expiration_date]).to include "is invalid" }
        end
      end

      %w(discover unionpay jcb maestro).each do |network|
        context "when network = #{network}" do
          subject                                       { build :credit_card, network: network }
          before                                        { is_expected.to be_invalid }
          it("has network 'is not suported' error")     { expect(subject.errors[:network]).to include "is not supported" }
        end
      end
    end

    context "with duplicated card_number" do
      before  { create :credit_card }
      subject { build :credit_card }
      before  { is_expected.to be_invalid }
      it("has Card number 'has already been taken' error")  { expect(subject.errors[:card_number]).to include "has already been taken" }
    end
  end
end

describe CreditCard, "#wallet" do
  context "when credit_card belongs to wallet" do
    subject                   { build(:credit_card).wallet }
    it("returns wallet")      { is_expected.to be_a Wallet }
  end

  context "when credit_card doesn't belong to any wallet" do
    subject                   { CreditCard.new.wallet }
    it("returns nil object")  { is_expected.to be_nil }
  end
end


describe CreditCard, "#user" do
  context "when credit_card belongs to user" do
    subject                   { build(:credit_card).user }
    it("returns user")        { is_expected.to be_a User }
  end

  context "when credit_card doesn't belong to any user" do
    subject                   { CreditCard.new.user }
    it("returns nil object")  { is_expected.to be_nil }
  end
end