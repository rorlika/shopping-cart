# frozen_string_literal: true

class PriceRulesController < ApplicationController
  before_action :set_product
  before_action :set_price_rule, only: %i[show edit update destroy]

  # GET products/1/price_rules
  def index
    @price_rules = @product.price_rule.nil? ? [] : [@product.price_rule]
  end

  # GET products/1/price_rules/1
  def show; end

  # GET products/1/price_rules/new
  def new
    @price_rule = @product.build_price_rule
  end

  # GET products/1/price_rules/1/edit
  def edit; end

  # POST products/1/price_rules
  def create
    @price_rule = @product.build_price_rule(price_rule_params)

    respond_to do |format|
      if @price_rule.save
        format.html { redirect_to([@price_rule.product, @price_rule], notice: 'Price rule was successfully created.') }
        format.json { render :show, status: :created, location: [@price_rule.product, @price_rule] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @price_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT products/1/price_rules/1
  def update
    respond_to do |format|
      if @price_rule.update(price_rule_params)
        format.html { redirect_to([@price_rule.product, @price_rule], notice: 'Price rule was successfully updated.') }
        format.json { render :show, status: :ok, location: [@price_rule.product, @price_rule] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE products/1/price_rules/1
  def destroy
    @price_rule.destroy

    respond_to do |format|
      format.html { redirect_to product_price_rules_url(@product) }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_price_rule
    @price_rule = @product.price_rule
  end

  # Only allow a trusted parameter "white list" through.
  def price_rule_params
    params.require(:price_rule).permit(:product_id, :rule_type, :discount_value, :min_quantity)
  end
end
