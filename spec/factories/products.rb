FactoryGirl.define do

  factory :product do
    sequence(:name)  { |n| "Product name #{n}" }
    price            1299
    description      'Description of product'
  end
end
