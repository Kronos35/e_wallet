require 'rails_helper'

describe TransactionRecord do
	subject { create :transaction }
  context "when valid" do
  end

  context "when invalid" do
  end
end


describe TransactionRecord, "#description" do
	%w(transfer fund withdrawal).each do |type|
		context "when type = #{type}" do
			it("assembles correct description message")
		end
	end
end