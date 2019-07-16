require 'rails_helper'

describe Abilities::WalletAbility do
  context "when initialized with user" do
    let(:user)  { create :tony_stark }
    subject     { Abilities::WalletAbility.new(user) }

    context "and evaluating user's wallet" do
      it("can read wallet")       { expect(subject.can?(:read, user.wallet)).to be_truthy }
      it("can update wallet")     { expect(subject.can?(:update, user.wallet)).to be_truthy }
      it("can destroy wallet")    { expect(subject.can?(:destroy, user.wallet)).to be_truthy }
    end

    context "and evaluating other user's wallet" do
      let(:other_user)            { create :peter_parker }
      it("cannot read wallet")    { expect(subject.can?(:read, other_user.wallet)).to be_falsey }
      it("cannot update wallet")  { expect(subject.can?(:update, other_user.wallet)).to be_falsey }
      it("cannot destroy wallet") { expect(subject.can?(:destroy, other_user.wallet)).to be_falsey }
    end
  end

  context "when initialized with nil user" do
    subject                       { Abilities::WalletAbility.new(nil) }
    let(:user)                    { create :peter_parker }
    it("cannot read wallet")      { expect(subject.can?(:read, user.wallet)).to be_falsey }
    it("cannot update wallet")    { expect(subject.can?(:update, user.wallet)).to be_falsey }
    it("cannot destroy wallet")   { expect(subject.can?(:destroy, user.wallet)).to be_falsey }
  end
end