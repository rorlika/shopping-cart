# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :carts, through: :orders

  has_one :price_rule, class_name: 'PriceRule', dependent: :destroy

  validates :name, :product_code, :price, presence: true
end
