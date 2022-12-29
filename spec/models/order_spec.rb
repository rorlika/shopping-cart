require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    %i[product cart].each do |f|
      it { should belong_to(f) }
    end
  end
end
