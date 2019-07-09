FactoryBot.define do
  factory :user do
    name      { "Peter Parker" }
    email     { "pparker@test.com" }
    password  { "123456" }
  end
end
