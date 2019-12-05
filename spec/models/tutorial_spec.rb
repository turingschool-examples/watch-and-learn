#  

require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'validations' do
  end

  describe 'relationships' do
  end

  describe 'methods' do
    it 'classroom_content' do
      tutorial_1 = create(:tutorial)
      tutorial_2 = create(:tutorial, classroom: true)

      result = Tutorial.classroom_content

      expect(result).to eq([tutorial_2])
    end
  end
end
