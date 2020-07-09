require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'relationships' do
    it { should have_many(:user_videos).dependent(:destroy)}
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
    it '.check_for_username' do
      User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0, username: 'takeller')

      5.times do
        create(:user)
      end

      expect(User.check_for_username?("takeller")).to eq(true)
      expect(User.check_for_username?("George")).to eq(false)
    end

    it '.create_with_omniauth' do
      user1 = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])
      auth = {
        :provider => 'github',
        :info => {:email => "#{user1.email}", :nickname => "Rostammahabadi", :uid => "60719241", :token => "123412341234"},
        :credentials => {:token => ENV['GITHUB_API_TOKEN_R']},
        :uid => "12341234"
      }
      expect(User.create_with_omniauth(auth)).to eq(true)
    end
  end

  describe 'Instance Methods' do
    it '#bookmarked_videos' do
      tutorial1 = create(:tutorial, title: "How to Tie Your Shoes")
      tutorial2 = create(:tutorial, title: "How to Cook a Steak")
      video1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial1)
      video2 = create(:video, title: "The Around the Tree Technique", tutorial: tutorial1)
      video3 = create(:video, title: "Steak Seasoning", tutorial: tutorial2, position: 0)
      video4 = create(:video, title: "Classic Sear", tutorial: tutorial2, position: 1)
      video5 = create(:video, title: "Reverse Sear", tutorial: tutorial2, position: 2)
      video6 = create(:video, title: "Resting", tutorial: tutorial2, position: 3)
      user = create(:user)
      user2 = create(:user)
      UserVideo.create({user_id: user.id, video_id: video1.id})
      UserVideo.create({user_id: user.id, video_id: video5.id})
      UserVideo.create({user_id: user.id, video_id: video6.id})
      UserVideo.create({user_id: user.id, video_id: video3.id})
      UserVideo.create({user_id: user.id, video_id: video4.id})

      UserVideo.create({user_id: user2.id, video_id: video3.id})
      UserVideo.create({user_id: user2.id, video_id: video4.id})

      expected_return = {
        tutorial1 => [video1],
        tutorial2 => [video3, video4, video5, video6]
      }

      expect(user.bookmarked_videos).to eq(expected_return)
    end

    it '#is_friend?' do
      user1 = create(:user, token:  ENV["GITHUB_API_TOKEN_R"])
      user2 = create(:user, token:  ENV["GITHUB_API_TOKEN"], username: 'takeller')
      user3 = create(:user)
      Friendship.create({user_id: user1.id, friend_id: user2.id})

      expect(user1.is_friend?('takeller')).to eq(true)
      expect(user3.is_friend?('takeller')).to eq(false)
    end
  end
end
