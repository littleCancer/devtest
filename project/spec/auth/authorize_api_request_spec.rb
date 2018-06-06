require 'rails_helper'

RSpec.describe AuthorizeApiRequest do

  let(:user) { create(:user) }

  let(:header) { { 'Authorization' => token_generator(user.id) } }

  subject(:invalid_request) { described_class.new({}) }

  subject(:valid_request) { described_class.new(header) }

  describe '#authorize' do

    context 'when valid request' do

      it 'returns user object' do
        result = valid_request.authorize
        expect(result[:user]).to eq(user)
      end

    end

    context 'when invalid request' do

      it 'raises a MissingToken error' do
        expect { invalid_request.authorize }
            .to raise_error(AppExceptionHandler::MissingToken, 'Missing token')
      end

    end

    context 'when invalid token' do

      subject(:invalid_request) do
        described_class.new 'Authorization' => token_generator(7)
      end

      it 'raises an InvalidToken error' do
        expect { invalid_request.authorize }
            .to raise_error(AppExceptionHandler::InvalidToken, /Invalid token/)
      end

    end

    context 'when token is expired' do
      let(:invalid_request_header) { { 'Authorization' => expired_token_generator(user.id) } }
      subject(:invalid_request) { described_class.new invalid_request_header }

      it 'raises AppExceptionHandler::ExpiredSignature error' do

        expect { invalid_request.authorize }
            .to raise_error(
                    AppExceptionHandler::InvalidToken, /Signature has expired/
                )

      end
    end

    context 'fake token' do

      let(:invalid_header) { { 'Authorization' => 'fake_token' } }
      subject(:invalid_request) { described_class.new invalid_header }

      it 'handles JWT::DecodeError' do

        expect { invalid_request.authorize }
            .to raise_error(
                    AppExceptionHandler::InvalidToken, /Not enough or too many segments/
                )

      end

    end

  end

end