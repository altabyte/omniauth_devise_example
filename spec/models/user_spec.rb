require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user) { FactoryGirl.create(:user) }

  it { is_expected.to be_valid }

end
