FactoryBot.define do
  factory :panel_provider do
    code { Faker::IDNumber.valid }
  end
end