require 'rails_helper'

RSpec.describe PriceRule, type: :model do
  describe 'validations' do
    subject { build(:price_rule) }

    %i[product].each do |f|
      it { should belong_to(f) }
    end

    it { is_expected.to validate_uniqueness_of(:product_id) }
    it { is_expected.to validate_inclusion_of(:rule_type).in_array(PriceRule::RULE_TYPES) }
  end
end
