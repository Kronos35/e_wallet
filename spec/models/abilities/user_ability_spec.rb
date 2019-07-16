require 'rails_helper'

describe Abilities::UserAbility do
  context "when initialized with user" do
    let(:user)  { create :tony_stark }
    subject 		{ Abilities::UserAbility.new(user) }

    context "and evaluating itself" do
      it("can read user")       { expect(subject.can?(:read, user)).to be_truthy }
      it("can update user")     { expect(subject.can?(:update, user)).to be_truthy }
      it("can destroy user")    { expect(subject.can?(:destroy, user)).to be_truthy }
    end

    context "and evaluating other users" do
      let(:other_user)          { create :peter_parker }
      it("can read user")       { expect(subject.can?(:read, other_user)).to be_truthy }
      it("cannot update user")  { expect(subject.can?(:update, other_user)).to be_falsey }
      it("cannot destroy user") { expect(subject.can?(:destroy, other_user)).to be_falsey }
    end
  end

  context "when initialized with nil user" do
    subject                     { Abilities::UserAbility.new(nil) }
    let(:user)                  { create :peter_parker }
    it("cannot read user")      { expect(subject.can?(:read, user)).to be_falsey }
    it("cannot update user")    { expect(subject.can?(:update, user)).to be_falsey }
    it("cannot destroy user")   { expect(subject.can?(:destroy, user)).to be_falsey }
  end
end