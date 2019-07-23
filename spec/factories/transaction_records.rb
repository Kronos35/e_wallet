FactoryBot.define do
  factory :transaction_record do
    type        { "transfer" }
    amount      { "300" }
    association :wallet, factory: :wallet
  end
end
