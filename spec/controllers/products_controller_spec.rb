# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let!(:product) { create(:product) }

  let(:collection_params) do
    { format: 'json' }
  end

  let(:member_params) do
    collection_params.merge(id: product.id)
  end

  let(:create_params) do
    collection_params.merge!(
      product: {
        product_code: 'product-code',
        name: 'product-name',
        price: 3.11
      }
    )
  end

  let(:invalid_params) do
    collection_params.merge!({ product: { product_code: '' } })
  end

  let(:update_params) do
    member_params.merge!({ product: product.attributes })
  end

  context '#products' do
    describe '#index' do
      before(:each) { get :index, params: collection_params }

      it { expect(response).to have_http_status(:ok) }
      it { expect(assigns(:products).size).to eq(1) }
      it { expect(assigns(:products)).to include(product) }
    end

    describe '#show' do
      before(:each) { get :show, params: member_params }

      it { expect(response).to have_http_status(:ok) }
      it { expect(assigns(:product)).to eq(product) }
    end

    describe '#new' do
      before(:each) { get :new }

      it { expect(response).to have_http_status(:ok) }
      it { expect(assigns(:product)).to be_a_new(Product) }
    end

    describe '#create' do
      context 'with valid params' do
        before(:each) { post :create, params: create_params }

        it { expect(response).to have_http_status(:created) }
      end

      context 'with invalid params' do
        before(:each) { post :create, params: invalid_params }

        it { expect(response).to have_http_status(:unprocessable_entity) }
      end
    end

    describe '#update' do
      context 'with valid params' do
        before(:each) { put :update, params: update_params }

        it { expect(response).to have_http_status(:ok) }
      end

      context 'with invalid params' do
        before(:each) { put :update, params: update_params.merge(invalid_params) }

        it { expect(response).to have_http_status(:unprocessable_entity) }
      end
    end

    describe '#destroy' do
      before(:each) { delete :destroy, params: member_params }

      it { expect(response).to have_http_status(:no_content) }
    end
  end
end
