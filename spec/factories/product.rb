FactoryBot.define do
  factory :product do
    sequence(:product_code) { |n| "product_code-#{n}" }
    sequence(:name) { |n| "name-#{n}" }
    price { rand(1..100) }
  end
end
