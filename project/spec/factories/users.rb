FactoryBot.define do
  factory :user, class: 'User' do
    name { Faker::Hobbit.character }
    email { Faker::Internet.email }
    panel_provider_id { nil }
    password { 'password' }
  end
end