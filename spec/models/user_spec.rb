require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'relationships' do
    it { should have_many(:user_videos).dependent(:destroy)}
    it { should have_many(:friends)}
    it { should have_many(:friendships)}
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
    describe '.methods' do
        it 'can get all github usernames' do
          user_1 = create(:user)
          user_1.update(github_username: "test user 1")
          user_2 = create(:user)
          user_2.update(github_username: "test user 2")
          user_3 = create(:user)

          expect(User.github_usernames).to eq(["test user 1", "test user 2"])
        end
    end
    describe '#methods' do
      it '#bookmark_tutorials' do
        user_1 = create(:user)
        tutorial = create(:tutorial)
        tutorial_2 = create(:tutorial)
        bookmark = create(:video, tutorial: tutorial, position: 1)
        bookmark_2 = create(:video, tutorial: tutorial_2, position: 2)
        bookmark_3 = create(:video, tutorial: tutorial_2, position: 1)
        UserVideo.create(user_id: user_1.id, video_id: bookmark.id)
        UserVideo.create(user_id: user_1.id, video_id: bookmark_2.id)
        UserVideo.create(user_id: user_1.id, video_id: bookmark_3.id)

        result_hash = {tutorial.id => [bookmark], tutorial_2.id => [bookmark_3, bookmark_2]}
        expect(user_1.bookmark_tutorials).to eq(result_hash)
      end
    end
  end
end
