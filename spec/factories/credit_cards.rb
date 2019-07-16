FactoryBot.define do
  factory :credit_card do
    brand           { 'visa' }
    card_number     { '4436059929117986' }
    year            { Time.now.year + 3 }
    month           { Time.now.month }
    association :wallet, factory: :wallet

    trait :visa do
      brand           { 'visa' }
      card_number     { '4436059929117986' }
    end

    trait :mastercard do
      brand           { 'mastercard' }
      card_number     { '5565383641741729' }
    end

    trait :american_express do
      brand           { 'american_express' }
      card_number     { '378912633850185' }
    end
  end

  factory :invalid_card, class: CreditCard do
    trait :blank_attribs do; end;
    trait :invalid_attribs do
      brand           { 'discover' }
      card_number     { 'ckssjbkncjnds5a4614' }
      association     :wallet, factory: :wallet
      year            { 30000 }
      month           { 13 }
    end
  end
end
