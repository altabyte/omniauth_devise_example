require 'rails_helper'

RSpec.describe User, type: :model do

  it { is_expected.to have_many(:identities) }
  it { expect(FactoryGirl.create(:user)).to be_valid }
end
