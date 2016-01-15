require 'rails_helper'

RSpec.describe Identity, type: :model do

  it { is_expected.to belong_to :user }

  it { expect(FactoryGirl.create(:identity)).to be_valid }
  it { expect(FactoryGirl.build(:identity, provider: nil)).not_to be_valid }
  it { expect(FactoryGirl.build(:identity, uid: nil)).not_to be_valid }
end
