FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {"123456"}
    password_confirmation {"123456"}
  end
end
FactoryBot.define do
  factory :admin, class: User do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {"123456"}
    password_confirmation {"123456"}
    role {1}
  end
end
