FactoryBot.define do
  factory :user, aliases: [:peter_parker] do
    name      { "Peter Parker" }
    email     { "pparker@test.com" }
    password  { "123456" }
    balance   { 0 }
  end

  factory :reed_richards, class: User do
    name      { "Reed Richards" }
    email     { "rrichards@test.com" }
    password  { "123456" }
    balance   { 0 }
  end
end
