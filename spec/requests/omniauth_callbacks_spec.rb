require 'rails_helper'

RSpec.describe 'OmniauthCallbacksController', type: :request do

  context 'Not signed in' do

    describe 'GET /users/auth/facebook' do
      it 'redirects to Facebook' do
        get '/users/auth/facebook'
        expect(response).to have_http_status(302)
        expect(response.location).to match /\Ahttps:\/\/www.facebook.com\//i
        puts "Redirecting to Facebook:   #{response.location}"
      end
    end

    describe 'GET /users/auth/linkedin' do
      it 'redirects to Linked in' do
        get '/users/auth/linkedin'
        expect(response).to have_http_status(302)
        expect(response.location).to match /\Ahttps:\/\/www.linkedin.com\//i
        puts "Redirecting to Linked in:   #{response.location}"
      end
    end
  end


  context 'Signed in user' do

    before do
      sign_in_as_a_valid_user  # Defined in spec/support/devise_support.rb
    end

    describe 'GET /users/auth/facebook' do
      it 'works! (now write some real specs)' do
        get products_path
        expect(response).to have_http_status(200)
      end
    end
  end
end
