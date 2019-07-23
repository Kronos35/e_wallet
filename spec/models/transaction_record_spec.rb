require 'rails_helper'

describe TransactionRecord do

  context "with valid attributes" do
    subject                 { create :transaction_record }
    it("is valid")          { is_expected.to be_valid }
    it("has type")          { expect(subject.type).to be_present }
    it("has description")   { expect(subject.description).to be_present }
    it("belongs to wallet") { expect(subject.wallet).to be_present }
  end
  
  %w(transfer fund withdrawal).each do |type|
    context "when type = #{type}" do
      subject               { create :transaction_record, type: type }
      it("is valid")        { is_expected.to be_valid }
    end
  end

  context "with blank attributes" do
    subject                                       { TransactionRecord.new }
    before                                        { is_expected.to be_invalid }
    it("has type 'can't be blank' error")         { expect(subject.errors[:type]).to include "can't be blank" }
    it("has wallet 'must exist' error")           { expect(subject.errors[:wallet]).to include "must exist" }
    it("has description 'can't be blank' error")  { expect(subject.errors[:description]).to include "can't be blank" }
    it("doesn't have amount errors")              { expect(subject.errors[:amount]).to be_blank }
  end

  context "with invalid attributes" do
    subject                                       { TransactionRecord.new(type: "invalid type", amount: "asoicvn") }
    before                                        { is_expected.to be_invalid }
    it("has type 'is not valid' error")           { expect(subject.errors[:type]).to include "is not valid" }
    it("has amount 'is not a number' error")      { expect(subject.errors[:amount]).to include "is not a number" }
  end
end


describe TransactionRecord, "#description" do
  %w(transfer fund withdrawal).each do |type|
    context "when type = #{type}" do
      subject { described_class.new(type: type) }
      before  { is_expected.to be_invalid }
      it("assembles correct description message") { expect(subject.description).to eq I18n.t "transfer_records.descriptions.#{type}" }
    end
  end
end