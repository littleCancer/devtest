FactoryBot.define do
  factory :location_group do
    name { Faker::StarWars.planet }
    country_id { Faker::Number.between(1, 10) }
    panel_provider_id { Faker::Number.between(1, 10) }
  end
end