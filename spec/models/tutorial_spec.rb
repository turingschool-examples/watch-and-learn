require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:description)}
    it {should validate_length_of(:title)
        .is_at_least(1)
    }

    it {should validate_length_of(:description)
        .is_at_least(1)
    }
  end

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
