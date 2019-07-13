FactoryBot.define do
  factory :user, aliases: [:peter_parker] do
    name      { "Peter Parker" }
    email     { "pparker@test.com" }
    password  { "123456" }
  end

  factory :reed_richards, class: User do
    name      { "Reed Richards" }
    email     { "rrichards@test.com" }
    password  { "123456" }
  end

  factory :tony_stark, class: User do
    name      { "Tony Stark" }
    email     { "tstark@test.com" }
    password  { "123456" }
  end

  factory :invalid_user, class: User do
    name      { nil }
    email     { nil }
    password  { nil }
  end
end
