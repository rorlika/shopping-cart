# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

green_tea_product = Product.create(product_code: 'GR1', name: 'Green Tea', price: 3.11)
strawberrie_product = Product.create(product_code: 'SR1', name: 'Strawberries', price: 5.00)
coffee_product = Product.create(product_code: 'CF1', name: 'Coffee', price: 11.23)

PriceRule.create([
                   {
                     product: green_tea_product,
                     rule_type: 'free_item',
                     discount_value: 1,
                     min_quantity: 1
                   },
                   {
                     product: strawberrie_product,
                     rule_type: 'fixed_amount',
                     discount_value: 0.5,
                     min_quantity: 3
                   },
                   {
                     product: coffee_product,
                     rule_type: 'percentage',
                     discount_value: 66.666667,
                     min_quantity: 3
                   }
                 ])
