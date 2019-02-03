require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'class methods' do
    it '.no_classroom_content' do
      create(:tutorial, classroom: true)
      create(:tutorial, classroom: true)
      tutorial_1 = create(:tutorial)
      tutorial_2 = create(:tutorial)
      
      tutorials = Tutorial.no_classroom_content

      expect(tutorials.count).to eq(2)
      expect(tutorials).to eq([tutorial_1, tutorial_2])
    end
  end
end
