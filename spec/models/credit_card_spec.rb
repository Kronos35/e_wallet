require 'rails_helper'

describe CreditCard do
  context "when valid" do
    subject                       { build :credit_card }
    before                        { is_expected.to be_valid }
    it("has year")                { expect(subject.year).to be_present }
    it("has month")               { expect(subject.month).to be_present }
    it("has brand")               { expect(subject.brand).to be_present }
    it("has Card number")         { expect(subject.card_number).to be_present }
    it("has CVV")                 { expect(subject.cvv).to be_present }
  end

  %i(visa mastercard american_express).each do |network|
    context "when network = #{network}" do
      subject         { build :credit_card, network }
      it("is valid")  { is_expected.to be_valid }
    end
  end
  
  context "when invalid" do
    context "with blank attributes" do 
      subject                                           { CreditCard.new }
      before                                            { is_expected.to be_invalid }
      it("has Wallet 'must exist error'")               { expect(subject.errors[:wallet]).to include "must exist" }
      it("has Card number 'can't be blank' error")      { expect(subject.errors[:card_number]).to include "can't be blank" }
      it("has year 'can't be blank' error")             { expect(subject.errors[:year]).to include "can't be blank" }
      it("has month 'can't be blank' error")            { expect(subject.errors[:month]).to include "can't be blank" }
      it("has cvv 'can't be blank' error")              { expect(subject.errors[:cvv]).to include "can't be blank" }
    end

    context "with invalid attributes" do 
      %w(visa mastercard american_express).each do |brand|
        context "when brand = #{brand}" do
          subject                                       { build(:invalid_card, :invalid_attribs, brand: 'visa') }
          before                                        { is_expected.to be_invalid }
          it("has year 'is invalid' error")             { expect(subject.errors[:year]).to include "must be less than 9999" }
          it("has month 'is invalid' error")            { expect(subject.errors[:month]).to include "must be less than 12" }
          it("has Card number 'is invalid' error")      { expect(subject.errors[:card_number]).to include "is invalid" }
          it("has cvv 'is too long' error")             { expect(subject.errors[:cvv]).to include "is too long (maximum is 3 characters)" }
        end
      end

      %w(discover unionpay jcb maestro).each do |brand|
        context "when brand = #{brand}" do
          subject                                       { build :credit_card, brand: brand }
          before                                        { is_expected.to be_invalid }
          it("has brand 'is not suported' error")       { expect(subject.errors[:brand]).to include "is not supported" }
        end
      end
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