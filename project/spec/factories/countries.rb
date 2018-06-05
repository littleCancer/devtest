FactoryBot.define do
  factory :country do
    code { Faker::Address.country_code_long }
    panel_provider_id { Faker::Number.between(1, 10) }
  end
end