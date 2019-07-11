FactoryBot.define do
  factory :credit_card do
    association :user, factory: :reed_richards
  end
end
