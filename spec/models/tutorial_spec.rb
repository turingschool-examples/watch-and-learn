require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'class methods' do
    it "should return tutorials not marked as classroom" do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial, classroom: true)

      expect(Tutorial.regular.first).to eq(tutorial1)
    end
  end
end
