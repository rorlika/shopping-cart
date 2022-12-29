# frozen_string_literal: true

class PriceRule < ApplicationRecord
  include Priceable

  RULE_TYPES = %w[fixed_amount percentage free_item].freeze

  belongs_to :product

  validates :product_id, uniqueness: true
  validates :rule_type, presence: true, inclusion: { in: RULE_TYPES }

  def discount_price_for(rule_type, quantity)
    return standard_price(product.price, quantity) if quantity < min_quantity

    send(rule_type, quantity)
  end

  private

  def fixed_amount(quantity)
    (product.price - discount_value) * quantity
  end

  def free_item(quantity)
    if quantity > min_quantity
      product.price * (quantity - discount_value)
    else
      standard_price(product.price, quantity)
    end
  end

  def percentage(quantity)
    product.price * quantity * (discount_value / 100)
  end
end
