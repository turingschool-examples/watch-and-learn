require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'relationships' do
    it {should have_one(:github_token)}
    it {should have_many(:friends)}
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

  describe 'Class Methods' do
    it 'gets the users bookmarked videos' do
      user = create(:user)
      user2 = create(:user)

      tutorial1 = create(:tutorial)
      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)

      tutorial2 = create(:tutorial)
      video3 = create(:video, tutorial_id: tutorial2.id)

      tutorial3 = create(:tutorial)
      video4 = create(:video, tutorial_id: tutorial3.id)
      video5 = create(:video, tutorial_id: tutorial3.id)

      uv1 = create(:user_video, user: user, video: video1)
      uv2 = create(:user_video, user: user, video: video2)
      uv3 = create(:user_video, user: user, video: video4)
      uv4 = create(:user_video, user: user2, video: video3)

      bookmarked_user_1 = {
        tutorial1 => [video1, video2],
        tutorial3 => [video4],
      }

      expect(user.bookmarks).to eq(bookmarked_user_1)
    end
  end
end
