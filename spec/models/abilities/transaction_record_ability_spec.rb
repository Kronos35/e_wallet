require 'rails_helper'

describe Abilities::TransactionRecordAbility do
  context "when initialized with user" do
    let(:user)  { create :tony_stark }
    subject     { Abilities::TransactionRecordAbility.new(user) }

    context "and evaluating user's transaction_record" do
      let(:transaction_record)                { create :transaction_record, wallet: user.wallet }
      it("cannot create transaction_record")  { expect(subject.can?(:create, transaction_record)).to be_falsey }
      it("can read transaction_record")       { expect(subject.can?(:read, transaction_record)).to be_truthy }
      it("cannot update transaction_record")  { expect(subject.can?(:update, transaction_record)).to be_falsey }
      it("cannot destroy transaction_record") { expect(subject.can?(:destroy, transaction_record)).to be_falsey }
    end

    context "and evaluating other user's transaction_record" do
      let(:other_user)                        { create :peter_parker }
      let(:transaction_record)                { create :transaction_record, wallet: other_user.wallet }
      it("cannot create transaction_record")  { expect(subject.can?(:create, transaction_record)).to be_falsey }
      it("cannot read transaction_record")    { expect(subject.can?(:read, transaction_record)).to be_falsey }
      it("cannot update transaction_record")  { expect(subject.can?(:update, transaction_record)).to be_falsey }
      it("cannot destroy transaction_record") { expect(subject.can?(:destroy, transaction_record)).to be_falsey }
    end
  end

  context "when initialized with nil user" do
    subject                                   { Abilities::TransactionRecordAbility.new(nil) }
    let(:transaction_record)                  { create :transaction_record }
    it("cannot read transaction_record")      { expect(subject.can?(:read, transaction_record)).to be_falsey }
    it("cannot update transaction_record")    { expect(subject.can?(:update, transaction_record)).to be_falsey }
    it("cannot destroy transaction_record")   { expect(subject.can?(:destroy, transaction_record)).to be_falsey }
  end
end