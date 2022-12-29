# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :product, :order, only: %i[create]

  def show; end

  def create
    order_actions

    respond_to do |format|
      format.html { redirect_to products_path, notice: 'Product was successfully added.' }
      format.turbo_stream
    end
  end

  def destroy
    Order.find_by(id: cart_params[:order_id]).destroy

    respond_to do |format|
      format.html { redirect_to products_path, notice: 'Product was successfully removed.' }
      format.turbo_stream
    end
  end

  private

  def cart_params
    params.permit(:order_id, :product_id, :quantity)
  end

  def product
    @product ||= Product.find_by(id: cart_params[:product_id])
  end

  def quantity
    cart_params[:quantity].to_i
  end

  def order
    @order ||= @cart.orders.find_by(product_id: @product.id)
  end

  def order_actions
    update_order
    destroy_order
    create_order
  end

  def update_order
    @order.update(quantity: quantity) if @order && quantity.positive?
  end

  def destroy_order
    @order.destroy if quantity <= 0
  end

  def create_order
    current_cart.orders.create(product: @product, quantity: quantity) unless @order
  end
end
