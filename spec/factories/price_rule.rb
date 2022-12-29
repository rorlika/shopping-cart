FactoryBot.define do
  factory :price_rule do
    association :product, factory: :product

    rule_type { PriceRule::RULE_TYPES.sample }
    discount_value { rand(1..10) }
    min_quantity { 3 }
  end
end
