require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'total' do
    let!(:green_tea_product) { create(:product, price: 3.11) }

    context 'when buy product without discount' do
      let!(:order) { create(:order, product: green_tea_product) }

      it { expect(order.cart.total).to eq(green_tea_product.price) }
    end

    context 'when buy one product with discount' do
      let!(:price_rule) { create_price_rule(green_tea_product, 'free_item', 1, 1) }
      let!(:order) { create(:order, product: green_tea_product) }

      it { expect(order.cart.total).to eq(green_tea_product.price) }
    end

    context 'when buy product with offer buy one get one free' do
      let!(:price_rule) { create_price_rule(green_tea_product, 'free_item', 1, 1) }
      let!(:order) { create(:order, product: green_tea_product, quantity: 2) }

      it { expect(order.cart.total).to eq(green_tea_product.price) }
    end

    context 'when buy product with discount for bulk purchases' do
      let!(:strawberrie_product) { create(:product, price: 5.0) }
      let!(:price_rule) { create_price_rule(strawberrie_product, 'fixed_amount', 0.5, 3) }
      let!(:order) { create(:order, product: green_tea_product, quantity: 1) }
      let!(:other_order) { create(:order, product: strawberrie_product, quantity: 3) }

      it { expect(Cart.all.map(&:total).sum).to eq(16.61) }
    end

    context 'when buy product with discount for total price' do
      let!(:strawberrie_product) { create(:product, price: 5.0) }
      let!(:coffe_product) { create(:product, price: 11.23) }
      let!(:price_rule) { create_price_rule(coffe_product, 'percentage', 66.666667, 3) }
      let!(:order) { create(:order, product: green_tea_product, quantity: 1) }
      let!(:second_order) { create(:order, product: strawberrie_product, quantity: 1) }
      let!(:third_order) { create(:order, product: coffe_product, quantity: 3) }

      it { expect(Cart.all.map(&:total).sum.round(2)).to eq(30.57) }
    end
  end

  def create_price_rule(product, rule_type, discount_value, min_quantity)
    create(
      :price_rule,
      product: product,
      rule_type: rule_type,
      discount_value: discount_value,
      min_quantity: min_quantity
    )
  end
end
