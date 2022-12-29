# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PriceRulesController, type: :controller do
  let!(:product) { create(:product) }
  let!(:price_rule) { create(:price_rule, product: product) }

  let(:collection_params) do
    { product_id: product.id }
  end

  let(:member_params) do
    collection_params.merge(id: price_rule.id)
  end

  let(:create_params) do
    collection_params.merge!(
      price_rule: {
        product_id: product.id,
        rule_type: 'fixed_amount',
        discount_value: 0.5,
        min_quantity: 3
      }
    )
  end

  let(:invalid_params) do
    collection_params.merge!({ price_rule: { rule_type: '' } })
  end

  let(:update_params) do
    member_params.merge!({ price_rule: price_rule.attributes })
  end

  context '#price_rules' do
    describe '#index' do
      before(:each) { get :index, params: collection_params }

      it { expect(response).to have_http_status(:ok) }
      it { expect(assigns(:price_rules).size).to eq(1) }
      it { expect(assigns(:price_rules)).to include(price_rule) }
    end

    describe '#show' do
      before(:each) { get :show, params: member_params }

      it { expect(response).to have_http_status(:ok) }
      it { expect(assigns(:product)).to eq(product) }
    end

    describe '#new' do
      before(:each) { get :new, params: collection_params }

      it { expect(response).to have_http_status(:ok) }
      it { expect(assigns(:price_rule)).to be_a_new(PriceRule) }
    end

    describe '#create' do
      context 'with valid params' do
        before(:each) { post :create, params: create_params }

        it { expect(response).to have_http_status(:found) }
      end

      context 'with invalid params' do
        before(:each) { post :create, params: invalid_params }

        it { expect(response).to have_http_status(:unprocessable_entity) }
      end
    end

    describe '#update' do
      context 'with valid params' do
        before(:each) { put :update, params: update_params }

        it { expect(response).to have_http_status(:found) }
      end

      context 'with invalid params' do
        before(:each) { put :update, params: update_params.merge(invalid_params) }

        it { expect(response).to have_http_status(:unprocessable_entity) }
      end
    end

    describe '#destroy' do
      before(:each) { delete :destroy, params: member_params }

      it { expect(response).to have_http_status(:found) }
    end
  end
end
