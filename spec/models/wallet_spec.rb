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

context Wallet, "#transaction_records" do
  let!(:wallet) { create :wallet }
  subject       { wallet.transaction_records }
  
  context "when associated with transaction_records" do
    let!(:transaction_record) { create :transaction_record, wallet: wallet }
    
    it "returns an array of transaction_records" do
      is_expected.to be_present
      is_expected.to all be_a TransactionRecord
      is_expected.to eq [transaction_record]
    end
  end

  context "when not associated with transaction_records" do
    before                        { expect(TransactionRecord.count).to eq 0 }
    it("returns an empty array")  { is_expected.to eq [] }
  end
end

describe Wallet, "#fund" do
  let(:wallet)      { create :wallet, balance: 200.50 }
  let(:credit_card) { create :credit_card, :visa, wallet: wallet }
  subject           { wallet.fund(20.50, credit_card.card_number) }

  context "when card has sufficient funds" do
    before                                                { allow_any_instance_of(CreditCard).to receive(:has_funds?).and_return(true) }
    it("increases the wallet's balance")                  { expect{ subject }.to change{ wallet.balance }.by(20.50) }
    it("adds an Item to the transaction history")         { expect{ subject }.to change{ wallet.transaction_records.count } }
    it("makes a request to get the money from the card")
  end

  context "when card doesn't have sufficient funds" do
    before                                                { allow_any_instance_of(CreditCard).to receive(:has_funds?).and_return(false) }
    it("doesn't increase the wallet's balance")           { expect{ subject }.not_to change{ wallet.balance } }
    it("doesn't add an Item to the transaction history")  { expect{ subject }.not_to change{ wallet.transaction_records.count } }
    it("makes a request to get the money from the card")
  end
end

describe Wallet, "#transfer" do
	let(:sender)	{ create(:tony_stark, balance: 200.50).wallet }
	subject 			{ sender.transfer 20.50, receiver }

  context "when a user transfers money to another user's wallet" do
  	context "while having sufficient funds" do
	  	let(:receiver)	{ create(:peter_parker).wallet }
	    it_behaves_like :successful_transfer, 20.50, true
	  end

	  context "while having insufficient funds" do
	  	before 					{ sender.update_attributes balance: 0.0 }
	  	let(:receiver)	{ create(:peter_parker).wallet }
	  	it_behaves_like :successful_transfer, 20.50, false
	  end
  end

  context "when transfering an amount of 0.0 to a wallet" do
  	let(:receiver)	{ create(:peter_parker).wallet }
  	subject 				{ sender.transfer 0.0, receiver }
    it_behaves_like :successful_transfer, 20.50, false
  end
end