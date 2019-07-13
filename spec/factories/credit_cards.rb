FactoryBot.define do
  factory :credit_card do
    network         { 'visa' }
    card_number     { '4436059929117986' }
    expiration_date { "05/#{Time.now.strftime('%y').to_i + 3}" }
    association :wallet, factory: :wallet

    trait :visa do
      network         { 'visa' }
      card_number     { '4436059929117986' }
    end

    trait :mastercard do
      network         { 'mastercard' }
      card_number     { '5565383641741729' }
    end

    trait :american_express do
      network         { 'american_express' }
      card_number     { '378912633850185' }
    end
  end

  factory :invalid_card, class: CreditCard do
    trait :blank_attribs do; end;
    trait :invalid_attribs do
      network     { 'discover' }
      card_number { 'ckssjbkncjnds5a4614' }
      association :wallet, factory: :wallet
      expiration_date { "006/2019" }
    end
  end
end
