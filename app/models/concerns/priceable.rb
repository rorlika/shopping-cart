module Priceable
  extend ActiveSupport::Concern

  def standard_price(price, quantity)
    price * quantity
  end
end
