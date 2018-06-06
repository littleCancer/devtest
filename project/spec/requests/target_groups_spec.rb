require 'rails_helper'

RSpec.describe 'Target Groups Api', type: :request do


  let!(:panel_provider) { create(:panel_provider) }
  let!(:user) { create(:user) }

  let!(:country) { create(:country, panel_provider: panel_provider) }
  let!(:target_groups) { create_list(:target_group, 14, panel_provider_id: panel_provider.id) }

  let(:headers) { valid_headers }
  let(:provider_id) { panel_provider.id }
  let(:country_code) { country.code }

  describe 'GET /target_groups' do

    before do
      target_groups[0].children << target_groups[1]
      target_groups[0].children << target_groups[2]
      target_groups[1].children << target_groups[3]
      target_groups[1].children << target_groups[4]
      target_groups[2].children << target_groups[5]
      target_groups[2].children << target_groups[6]

      target_groups[7].children << target_groups[8]
      target_groups[7].children << target_groups[9]
      target_groups[8].children << target_groups[10]
      target_groups[8].children << target_groups[11]
      target_groups[9].children << target_groups[12]
      target_groups[9].children << target_groups[13]

      country.target_groups << target_groups[0]
      country.target_groups << target_groups[7]

      panel_provider.countries << country


    end

  end

  context 'public api' do

    before { get "/target_groups/#{provider_id}?country_code=#{country_code}", headers: headers }

    context 'when country exists' do

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns target groups list' do
        expect(json).not_to be_empty
        expect(json.size).to eq(14)
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

    before do
      get "/target_groups/#{provider_id}?country_code=#{country_code}", headers: headers
    end

    context 'when country exists' do

      let(:user) { create(:user, panel_provider_id: panel_provider.id) }
      let(:headers) { valid_headers_private_api }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns location list' do
        expect(json).not_to be_empty
        expect(json.size).to eq(14)
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

      it 'returns status code 401' do
        expect(response).to have_http_status(403)
      end

      it 'returns not authorized message' do
        expect(response.body).to match(/Forbidden/)
      end

    end

  end



end