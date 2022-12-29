# frozen_string_literal: true

module ProductsHelper
  def number_to_euro(amount)
    number_to_currency(amount, unit: '€')
  end
end
