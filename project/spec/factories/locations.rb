FactoryBot.define do
  factory :location do
    name { Faker::LordOfTheRings.location }
    external_id { Faker::Address.zip }
    secret_code { Faker::Address.zip }
  end
end