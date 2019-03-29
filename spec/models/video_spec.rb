# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:position) }
  end
end
