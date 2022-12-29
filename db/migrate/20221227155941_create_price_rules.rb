# frozen_string_literal: true

class CreatePriceRules < ActiveRecord::Migration[7.0]
  def change
    create_table :price_rules do |t|
      t.references :product, null: false, foreign_key: true, index: { unique: true }
      t.string :rule_type
      t.decimal :discount_value
      t.integer :min_quantity

      t.timestamps
    end
  end
end
