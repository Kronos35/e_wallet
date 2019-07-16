require 'rails_helper'

describe Abilities::CreditCardAbility do
  context "when initialized with user" do
    let(:user)  { create :tony_stark }
    subject { Abilities::CreditCardAbility.new(user) }

    context "and evaluating user's credit_card" do
      let(:credit_card)                 { create :credit_card, wallet: user.wallet }
      it("can fund credit_card")      	{ expect(subject.can?(:fund, credit_card)).to be_truthy }
      it("can create credit_card")      { expect(subject.can?(:create, credit_card)).to be_truthy }
      it("can read credit_card")        { expect(subject.can?(:read, credit_card)).to be_truthy }
      it("can update credit_card")      { expect(subject.can?(:update, credit_card)).to be_truthy }
      it("can destroy credit_card")     { expect(subject.can?(:destroy, credit_card)).to be_truthy }
    end

    context "and evaluating other user's credit_card" do
      let(:other_user)                  { create :peter_parker }
      let(:credit_card)                 { create :credit_card, wallet: other_user.wallet }
      it("cannot fund credit_card")   	{ expect(subject.can?(:fund, credit_card)).to be_falsey }
      it("cannot create credit_card")   { expect(subject.can?(:create, credit_card)).to be_falsey }
      it("cannot read credit_card")     { expect(subject.can?(:read, credit_card)).to be_falsey }
      it("cannot update credit_card")   { expect(subject.can?(:update, credit_card)).to be_falsey }
      it("cannot destroy credit_card")  { expect(subject.can?(:destroy, credit_card)).to be_falsey }
    end
  end

  context "when initialized with nil user" do
    subject                             { Abilities::CreditCardAbility.new(nil) }
    let(:credit_card)                   { create :credit_card }
    it("cannot fund credit_card")     	{ expect(subject.can?(:fund, credit_card)).to be_falsey }
    it("cannot create credit_card")     { expect(subject.can?(:create, credit_card)).to be_falsey }
    it("cannot read credit_card")       { expect(subject.can?(:read, credit_card)).to be_falsey }
    it("cannot update credit_card")     { expect(subject.can?(:update, credit_card)).to be_falsey }
    it("cannot destroy credit_card")    { expect(subject.can?(:destroy, credit_card)).to be_falsey }
  end
end