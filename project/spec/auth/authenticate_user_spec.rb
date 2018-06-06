require 'rails_helper'

RSpec.describe AuthenticateUser do

  let(:user) { create(:user) }

  subject(:valid_auth) { described_class.new(user.email, user.password) }

  subject(:invalid_auth) { described_class.new('james@bond.net', '007') }

  describe '#authenticate' do

    context 'when valid credentials' do

      it 'returns auth token' do
        token = valid_auth.authenticate
        expect(token).not_to be_nil
      end

    end

    context 'when invalid credentials' do
      it 'raises an authentication error' do
        expect { invalid_auth.authenticate }
            .to raise_error(AppExceptionHandler::AuthenticationError,
                            /Invalid credentials/)
      end
    end

  end

end