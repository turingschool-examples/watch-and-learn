require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'class methods' do
    describe '.public' do
      it 'scopes the returns to only public tutorials' do
        public_tutorials = create_list(:tutorial, 3)
        classroom_tutorial = create(:classroom_tutorial)

        expect(Tutorial.public_tutorials).to eq(public_tutorials)
      end
    end
  end
end
