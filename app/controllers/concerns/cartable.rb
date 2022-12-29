# frozen_string_literal: true

module Cartable
  extend ActiveSupport::Concern

  included do
    before_action :init_cart
  end

  private

  def init_cart
    @cart ||= Cart.find_by(id: session[:cart_id])

    return unless @cart.nil?

    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  def current_cart
    return unless session[:cart_id]

    @current_cart ||= Cart.find(session[:cart_id])
  end
end
