# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :products, through: :orders

  def total
    orders.to_a.sum(&:total)
  end
end
