FactoryBot.define do
  factory :transaction_record do
    type        { "Transfer" }
    description { "Money transfer" }
    association :wallet, factory: :wallet
  end
end
