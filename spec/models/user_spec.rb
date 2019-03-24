require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
    it {should validate_presence_of(:password)}

    it {should validate_length_of(:first_name).
        is_at_least(1)
    }
    it {should validate_length_of(:last_name).
        is_at_least(1)
    }
    it {should validate_length_of(:email).
        is_at_least(1)
    }

    it {should validate_uniqueness_of(:email)}
    it {should validate_confirmation_of(:password)}
    it {should have_secure_password}
  end

  describe 'relationships' do
    it {should have_many :friends}
    it {should have_many(:friend_users).through(:friends)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'class methods' do
    describe '.bookmarked_videos' do
      it 'returns the videos a user has bookmarked in grouped by tutorial then video position' do
        tutorial_1 = create(:tutorial)
        tutorial_2 = create(:tutorial)
        video_2 = create(:video, position: 2, tutorial_id: tutorial_1.id)
        video_3 = create(:video, position: 3, tutorial_id: tutorial_1.id)
        video_4 = create(:video, position: 1, tutorial_id: tutorial_2.id)
        video_1 = create(:video, position: 1, tutorial_id: tutorial_1.id)
        user = create(:user)
        create(:user_video, user_id: user.id, video_id: video_3.id)
        create(:user_video, user_id: user.id, video_id: video_4.id)
        create(:user_video, user_id: user.id, video_id: video_1.id)

        expected = [video_1, video_3, video_4]

        expect(User.bookmarked_videos(user)).to eq(expected)
      end
    end
  end
end
