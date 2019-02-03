require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'class methods' do
    it '.no_classroom_content' do
      create(:tutorial, classroom: true)
      create(:tutorial, classroom: true)
      create(:tutorial)
      create(:tutorial)
      tutorials = Tutorial.no_classroom_content

      expect(tutorials.count).to eq(2)
    end
  end
end
