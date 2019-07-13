FactoryBot.define do
  factory :wallet do
    balance { 0 }
    association :user, factory: :peter_parker
  end
end
