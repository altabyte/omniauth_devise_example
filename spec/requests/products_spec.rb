require 'rails_helper'

RSpec.describe 'Products', type: :request do

  context 'Not signed in' do

    describe 'GET /products' do
      it 'works! (now write some real specs)' do
        get products_path
        expect(response).to have_http_status(302)
      end
    end
  end


  context 'Signed in user' do

    before do
      sign_in_as_a_valid_user  # Defined in spec/support/devise_support.rb
    end

    describe 'GET /products' do
      it 'works! (now write some real specs)' do
        get products_path
        expect(response).to have_http_status(200)
      end
    end
  end
end
