FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    user_name { Faker::Internet.username(specifier: 1..10)}
    password { Faker::Internet.password }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    cohort { '1911' }
    status { 1 }
  end
end
