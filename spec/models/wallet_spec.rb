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

describe Wallet, "#exchange_balance" do
  let!(:wallet)  { create :wallet, balance: 200.50 }

  context "when converting from usd to mxn" do
    subject     { wallet.exchange(:mxn) }
    it("requests exchange rate")                  { expect{ subject }.to change{ wallet.reload.balance } }
    it("requests correctly converts MXN to USD")  { expect{ subject }.to change{ wallet.currency_type }.from('usd').to('mxn') }
  end
end