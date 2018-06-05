require 'rails_helper'

RSpec.describe  'Locations API', type: :request do

  let!(:panel_provider) { create(:panel_provider) }
  let!(:user) { create(:user) }

  let!(:country) { create(:country) }
  let!(:location_group_east) { create(:location_group) }
  let!(:location_group_west) { create(:location_group) }
  let!(:locations) { create_list(:location, 20) }

  let(:headers) { valid_headers }

  let(:provider_id) { panel_provider.id }
  let(:country_code) { country.country_code }

  describe 'GET /locations' do

    before do

      panel_provider.countries << country
      country.location_groups << location_group_east
      country.location_groups << location_group_west
      location_group_east.locations << locations[0, 12]
      location_group_west.locations << locations[10, 19]

    end

  end

end