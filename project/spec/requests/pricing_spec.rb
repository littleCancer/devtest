require 'rails_helper'

RSpec.describe 'Pricing Api' do

  let!(:panel_provider1) { create(:panel_provider) }
  let!(:panel_provider2) { create(:panel_provider) }
  let!(:panel_provider3) { create(:panel_provider) }

  let(:panel_provider) { panel_provider1 }

  let!(:user) { create(:user, panel_provider_id: panel_provider.id) }

  let!(:country) { create(:country, panel_provider_id: panel_provider.id) }
  let(:country_code) { country.code }

  let!(:target_group) { create(:target_group) }
  let (:target_group_id) { target_group.id }

  let(:headers) { valid_headers_private_api }

  let(:location_group1) { create(:location_group, country_id: country.id) }
  let(:location_group2) { create(:location_group, country_id: country.id) }

  let(:locations) do
    locations = create_list(:location, 40)
    locations.each do |loc|
      location_group1.locations << loc
    end

    locations
  end


  let(:locations_param) do

    result = []

    locations[0..20].each do |loc|
      result << { id: loc.id, panel_size: Faker::Number.between(1, 140) }
    end
    result
  end

  let(:params) do
    params = {
        'target_group_id' => target_group_id,
        'locations' => locations_param
    }.to_json

    params

  end


  describe 'POST country/:country_code/price ' do

    before do
      post "/country/#{country_code}/price", params: params, headers: headers
    end

    context 'when valid user' do

      context 'when valid params' do

        it 'returns status 200' do
          expect(response).to have_http_status(200)
        end

        it 'returns price' do
          expect(json['price']).not_to be_nil
        end

      end

      context 'when invalid params' do

        context 'invalid country code' do

          let(:country_code) { 'conanbarbarian' }

          it 'returns status code 422' do
            expect(response).to have_http_status(422)
          end

          it 'returns not found country' do
            expect(response.body).to match(/Validation failed/)
          end

        end

        context 'invalid target_group' do

          let(:target_group_id) {1300}

          it 'returns status code 404' do
            expect(response).to have_http_status(422)
          end

          it 'returns not found target group' do
            expect(response.body).to match(/Validation failed/)
          end

        end

        context 'location does not belong to country' do

          let(:locations_param) do

            result = []

            locations[0..20].each do |loc|
              result << { id: loc.id, panel_size: Faker::Number.between(1, 140) }
            end
            result[10][:id] = 1500
            result
          end

          it 'returns status code 422' do
            expect(response).to have_http_status(422)
          end

          it 'returns invalid request message' do
            expect(response.body).to match(/Validation failed/)
          end

        end


      end

      context 'when param is missing' do

        let(:params) { { 'locations' => locations_param }.to_json }

        it 'returns status code 400' do
          expect(response).to have_http_status(422)
        end

        it 'returns invalid request message' do
          expect(response.body).to match(/Validation failed/)
        end

      end

      context 'user has no right to use private api' do
        let(:user) { create(:user) }

        it 'returns status code 403' do
          expect(response).to have_http_status(403)
        end

        it 'returns forbidden message' do
          expect(response.body).to match(/Forbidden/)
        end

      end

    end

  end

end