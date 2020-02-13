# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validations' do
    it { should validate_presence_of :position }
    it { should validate_numericality_of(:position).is_greater_than_or_equal_to(0) }
  end
end
