require 'rails_helper'

describe Wallet do
  %w(mxn usd aud eur).each do |curr_type|
    context "when currency_type = '#{curr_type}'" do
      subject                 { build :wallet, currency_type: curr_type }
      it("is valid")          { is_expected.to be_valid }
      it("has balance")       { expect(subject.balance).to be_present }
      it("has currency_type") { expect(subject.currency_type).to eq curr_type }
    end
  end

  %w(mwk mop luf ltl).each do |curr_type|
    context "when currency_type = '#{curr_type}'" do
      subject                 { build :wallet, currency_type: curr_type }

      it("has currency_type 'is not supported' error") do
        is_expected.to be_invalid
        expect(subject.errors[:currency_type]).to include 'is not supported'
      end
    end
  end
end
