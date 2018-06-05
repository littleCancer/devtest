FactoryBot.define do
  factory :target_group do
    name { Faker::Job.field }
    external_id { Faker::IDNumber.valid }
    parent_id { nil }
    secret_code { Faker::IDNumber.valid }
    panel_provider_id { Faker::Number.between(1, 10) }
  end
end