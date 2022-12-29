# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let!(:product) { create(:product) }
  let!(:order) { create(:order, product: product) }

  let(:collection_params) do
    {}
  end

  let(:member_params) do
    collection_params.merge(order_id: order.id)
  end

  let(:create_params) do
    collection_params.merge!(
      order_id: order.id,
      product_id: product.id,
      quantity: 2
    )
  end

  context '#carts' do
    describe '#show' do
      before(:each) { get :show, params: member_params }

      it { expect(response).to have_http_status(:ok) }
    end

    describe '#create' do
      context 'when order not created yet' do
        before(:each) { post :create, params: create_params }

        it { expect(response).to have_http_status(:found) }
        it { expect(product.carts).to include(assigns(:cart)) }
        it { expect(product.carts.count).to eq(2) }
        it { expect(product.orders.count).to eq(2) }
        it { expect(assigns(:cart).orders.find_by(product_id: product.id)).to be_present }
      end

      context 'when order is created' do
        before(:each) { post :create, params: create_params, session: { 'cart_id' => product.carts.first.id } }

        it { expect(response).to have_http_status(:found) }
        it { expect(product.carts.count).to eq(1) }
        it { expect(product.orders.count).to eq(1) }
        it { expect(product.orders.first.quantity).to eq(create_params[:quantity]) }
      end

      context 'when order quantity is 0' do
        before(:each) { post :create, params: create_params.merge(quantity: 0), session: { 'cart_id' => product.carts.first.id } }

        it { expect(response).to have_http_status(:found) }
        it { expect(product.carts.count).to eq(0) }
        it { expect(product.orders.count).to eq(0) }
      end
    end

    describe '#destroy' do
      before(:each) { delete :destroy, params: member_params }

      it { expect(response).to have_http_status(:found) }
      it { expect(product.orders.count).to eq(0) }
    end
  end
end
