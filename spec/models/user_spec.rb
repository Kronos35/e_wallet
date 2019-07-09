require 'rails_helper'

describe User do
  context "when valid" do
    subject         { create :user }
    before          { is_expected.to be_valid }
    it("has name")  { expect(subject.name).to be_present }
    it("has email") { expect(subject.email).to be_present }
  end

  context "when invalid" do
    subject { User.new }
    before  { is_expected.to be_invalid }

    it("has name 'can't be blank' error")   { expect(subject.errors[:name]).to include 'can\'t be blank' }
    it("has email 'can't be blank' error")  { expect(subject.errors[:email]).to include 'can\'t be blank' }
  end
end
