FactoryBot.define do
  factory :wallet do
    association :user, factory: :peter_parker
  end
end
