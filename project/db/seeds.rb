PANEL_PROVIDERS_CODES = %w[times_a 10_arrays times_html].freeze

COUNTRIES = [
  { code: "PL", panel_provider_code: "times_a" },
  { code: "US", panel_provider_code: "10_arrays" },
  { code: "UK", panel_provider_code: "times_html" }
].freeze

LOCATION_GROUPS = [
    { name: 'Eastern Coast', country_code: 'PL' },
    { name: 'Central', country_code: 'US' },
    { name: 'Middle West', country_code: 'UK' },
    { name: 'Western Coast', country_code: 'UK' }
].freeze

LOCATIONS = [
  { name: "New York" },
  { name: "Los Angeles" },
  { name: "Chicago" },
  { name: "Houston" },
  { name: "Philadelphia" },
  { name: "Phoenix" },
  { name: "San Antonio" },
  { name: "San Diego" },
  { name: "Dallas" },
  { name: "San Jose" },
  { name: "Austin" },
  { name: "Jacksonville" },
  { name: "San Francisco" },
  { name: "Indianapolis" },
  { name: "Columbus" },
  { name: "Fort Worth" },
  { name: "Charlotte" },
  { name: "Detroit" },
  { name: "El Paso" },
  { name: "Seattle" }
].freeze

TARGET_GROUPS = [
    { name: 'Sports', external_id: 'spo', country_code: 'PL'},
    { name: 'Winter Sports', external_id: 'wsp', external_parent_id: 'spo' },
    { name: 'Summer Sports', external_id: 'ssp', external_parent_id: 'spo' },
    { name: 'Skiing', external_id: 'ski', external_parent_id: 'wsp' },
    { name: 'Boarding', external_id: 'bor', external_parent_id: 'wsp' },
    { name: 'Surfing', external_id: 'sur', external_parent_id: 'ssp' },
    { name: 'Scuba', external_id: 'scu', external_parent_id: 'ssp' },
    { name: 'Monuments', external_id: 'mon', country_code: 'UK'},
    { name: 'History', external_id: 'his', external_parent_id: 'mon' },
    { name: 'Modern', external_id: 'mod', external_parent_id: 'mon' },
    { name: 'Battles', external_id: 'bat', external_parent_id: 'his' },
    { name: 'Foundation', external_id: 'fou', external_parent_id: 'his' },
    { name: 'Happiness', external_id: 'hap', external_parent_id: 'mod' },
    { name: 'Labor', external_id: 'lab', external_parent_id: 'mod' },
    { name: 'Restaurants', external_id: 'res', country_code: 'US'},
    { name: 'Italian', external_id: 'ita', external_parent_id: 'res'},
    { name: 'Mexican', external_id: 'mex', external_parent_id: 'res'},
    { name: 'Pizzas', external_id: 'pzz', external_parent_id: 'ita'},
    { name: 'Pastas', external_id: 'pas', external_parent_id: 'ita'},
    { name: 'Tacos', external_id: 'tac', external_parent_id: 'mex'},
    { name: 'Nachos', external_id: 'nch', external_parent_id: 'mex'},
    { name: 'Festivals', external_id: 'fes', country_code: 'UK'},
    { name: 'Rock Music', external_id: 'roc', external_parent_id: 'fes'},
    { name: 'Pop Music', external_id: 'pop', external_parent_id: 'fes'},
    { name: 'Spring Tour', external_id: 'str', external_parent_id: 'roc'},
    { name: 'Winter Rock', external_id: 'wtr', external_parent_id: 'roc'},
    { name: 'For Ladies', external_id: 'fol', external_parent_id: 'pop'},
    { name: 'Winter Delight', external_id: 'wde', external_parent_id: 'pop'}
]

PANEL_PROVIDERS_CODES.each { |panel_provider_code| PanelProvider.create!(code: panel_provider_code) }

COUNTRIES.each do |country|
  Country.create!(
    code: country.fetch(:code),
    panel_provider: PanelProvider.find_by!(code: country.fetch(:panel_provider_code))
  )
end

LOCATION_GROUPS.each do |location_group|
  country = Country.find_by!(code: location_group.fetch(:country_code))
  LocationGroup.create!(name: location_group.fetch(:name), country_id: country.id,
                        panel_provider_id: country.panel_provider_id)
end

LOCATIONS.each do |location|
  Location.create!(
    name: location.fetch(:name),
    external_id: SecureRandom.uuid,
    secret_code: SecureRandom.hex(64)
  )
end

TARGET_GROUPS.each do |target_group|
  name = target_group.fetch(:name)
  external_id = target_group.fetch(:external_id)

  country = Country.find_by!(target_group.fetch(:country_code)) if target_group.key?(:country_code)
  parent =  TargetGroup.find_by!(target_group.fetch(:external_parent_id)) if target_group.key?(:external_parent_id)

  panel_provider_id = country ? country.panel_provider_id : parent.panel_provider_id

  target_group = TargetGroup.create!(name: name, external_id: external_id, secret_code: SecureRandom.hex(64),
                      panel_provider_id: panel_provider_id)

  country.target_groups << target_group if country
  parent.children << target_group if parent

end

#users

User.create!(name: 'Normal User',
             email: 'captain@wakanda.com',
             password: 'foobar',
             password_confirmation: 'foobar')

User.create!(name: 'Provider Member',
             email: 'thor@asgard.net',
             password: 'foobar',
             password_confirmation: 'foobar')