require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  # initialize test data
  describe 'POST /users' do
    let(:valid_attributes) { {
        name: 'kai',
        email: 'kevinctzhang@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      }
    }
    context 'when the request is valid' do
      before { post '/users', params: valid_attributes }

      it 'creates a user' do
        expect(json['email']).to eq('kevinctzhang@gmail.com')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/users', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: email can't be blank/)
      end
    end
  end
end
