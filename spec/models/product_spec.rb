require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    %i[name product_code price].each do |f|
      it { should validate_presence_of(f) }
    end
  end
end
