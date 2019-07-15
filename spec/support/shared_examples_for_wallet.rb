shared_examples :successful_transfer do |amount, flag|
  if flag
    it("increases the receiver's balance")          { expect{ subject }.to change{ receiver.balance }.by(amount) }
    it("decreases sending wallet's balance")        { expect{ subject }.to change{ sender.balance }.by(-amount) }
    it("adds an Item to the transaction history")   { expect{ subject }.to change{ sender.transaction_records.count } }
  else
    it("doesn't increase the receiver's balance")   { expect{ subject }.not_to change{ receiver.balance } }
    it("doesn't decrease sending wallet's balance") { expect{ subject }.not_to change{ sender.balance } }
    it("doesn't add an Item to the history")        { expect{ subject }.not_to change{ sender.transaction_records.count } }
  end
end