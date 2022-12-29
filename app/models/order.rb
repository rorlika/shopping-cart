# frozen_string_literal: true

class Order < ApplicationRecord
  include Priceable

  belongs_to :product
  belongs_to :cart

  delegate :price_rule, to: :product, allow_nil: true

  def total
    price_rule.present? ? discount_price : standard_price(product.price, quantity)
  end

  def discount_price
    price_rule.discount_price_for(price_rule.rule_type, quantity)
  end
end
