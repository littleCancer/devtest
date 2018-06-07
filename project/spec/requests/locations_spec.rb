require 'rails_helper'

RSpec.describe  'Locations API', type: :request do

  let!(:panel_provider) { create(:panel_provider) }
  let!(:user) { create(:user) }

  let!(:country) { create(:country, panel_provider: panel_provider) }
  let!(:location_group_east) { create(:location_group, country_id: country.id) }
  let!(:location_group_west) { create(:location_group, country_id: country.id) }
  let!(:locations) { create_list(:location, 20) }

  let(:headers) { valid_headers }

  let(:provider_id) { panel_provider.id }
  let(:country_code) { country.code }

  describe 'GET /locations' do

    before do

      panel_provider.countries << country
      country.location_groups << location_group_east
      country.location_groups << location_group_west
      location_group_east.locations << locations[0, 12]
      location_group_west.locations << locations[10, 19]

    end

    context 'public api' do

      before { get "/locations/#{provider_id}?country_code=#{country_code}", headers: headers }

      context 'when country exists' do

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        it 'returns location list' do
          expect(json).not_to be_empty
          expect(json.size).to eq(20)
        end

      end

      context 'when country does not exist' do

        let(:country_code) { 'foocode' }

        it 'returns status code 404' do

          expect(response).to have_http_status(404)
        end

        it 'returns not found message' do
          expect(response.body).to match(/Couldn't find Country/)
        end

      end

    end

    context 'private api' do

      before { get "/locations/#{provider_id}?country_code=#{country_code}", headers: headers }

      context 'when country exists' do

        let(:user) { create(:user, panel_provider_id: panel_provider.id) }
        let(:headers) { valid_headers_private_api }

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        it 'returns location list' do
          expect(json).not_to be_empty
          expect(json.size).to eq(20)
        end

      end

      context 'when country does not exist' do

        let(:user) { create(:user, panel_provider_id: panel_provider.id) }
        let(:headers) { valid_headers_private_api }
        let(:country_code) { 'foocode' }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns not found message' do
          expect(response.body).to match(/Couldn't find Country/)
        end

      end

      context 'when user has no rights to access private api' do

        let(:headers) { valid_headers_private_api }

        it 'returns status code 403' do
          expect(response).to have_http_status(403)
        end

        it 'returns not forbidden message' do
          expect(response.body).to match(/Forbidden/)
        end

      end

    end

  end

end