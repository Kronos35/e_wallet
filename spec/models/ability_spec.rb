require 'rails_helper'

describe Ability, "#initialize" do
  let(:user)    { create :user }

  context "when initialized with user" do
    subject { Ability.new(user).permissions.values.map(&:values).flatten.map(&:keys).flatten.uniq }

    it("is merged with UserAbility")            			{ is_expected.to include "User" }
    it("is merged with WalletAbility")          			{ is_expected.to include "Wallet" }
    it("is merged with CreditCardAbility")      			{ is_expected.to include "CreditCard" }
    it("is merged with TransactionRecordAbility")			{ is_expected.to include "TransactionRecord" }
  end

  context "when initialized with nil user" do
    subject { Ability.new(nil).permissions.values.map(&:values).flatten.map(&:keys).flatten.uniq }

    it("is not merged with UserAbility")        			{ is_expected.not_to include "User" }
    it("is not merged with WalletAbility")      			{ is_expected.not_to include "Wallet" }
    it("is not merged with CreditCardAbility")  			{ is_expected.not_to include "CreditCard" }
    it("is not merged with TransactionRecordAbility")	{ is_expected.not_to include "TransactionRecord" }
  end
end