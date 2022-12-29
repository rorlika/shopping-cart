FactoryBot.define do
  factory :order do
    association :product, factory: :product
    association :cart, factory: :cart

    quantity { 1 }
  end
end
