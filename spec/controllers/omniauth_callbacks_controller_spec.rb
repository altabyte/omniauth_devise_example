require 'rails_helper'

# https://github.com/intridea/omniauth/wiki/Integration-Testing

#OmniAuth.config.test_mode = true
#OmniAuth.config.add_mock(:facebook, { email: 'user@email.com', uid: '12345' })

RSpec.describe OmniauthCallbacksController, type: :controller do

  before do
    request.env['devise.mapping'] = Devise.mappings[:user] # If using Devise
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
  end

  describe 'dynamic methods' do
    let(:controller) { OmniauthCallbacksController.new }

    it { expect(controller.methods).to include :facebook }
    it { expect(controller.methods).to include :linkedin }
  end

end
