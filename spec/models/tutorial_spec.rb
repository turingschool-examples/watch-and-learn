# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'class methods' do
    it 'filters tutorials based on classroom boolean and user type' do
      user = nil

      tutorial1 = create(:tutorial, classroom: false)
      create(:tutorial, classroom: true)

      expect(Tutorial.filtered(user).count).to eq(1)
      expect(Tutorial.filtered(user).first.id).to eq(tutorial1.id)
    end
  end
end
