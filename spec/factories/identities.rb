require 'securerandom'

FactoryGirl.define do

  factory :identity do
    provider  'facebook'
    uid       SecureRandom.uuid
  end
end
