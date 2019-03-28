require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
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

  context 'instance methods' do
    it '#connect_github' do
      user = create(:user, email: "test@email.com", password: "test")

      data = {"provider"=>"github",
           "uid"=>"42525195",
           "info"=>
            {"nickname"=>"Mackenzie-Frey",
             "email"=>nil,
             "name"=>"Mackenzie Frey",
             "image"=>"https://avatars0.githubusercontent.com/u/42525195?v=4",
             "urls"=>{"GitHub"=>"https://github.com/Mackenzie-Frey", "Blog"=>"https://www.linkedin.com/in/mackenzie-frey/"}},
           "credentials"=>{"token"=>"#{ENV['OAUTH_TEST_TOKEN']}", "expires"=>false},
           "extra"=>
           {"raw_info"=>
             {"login"=>"Mackenzie-Frey"} } }

      expect(user.github_token).to eq(nil)

      user.connect_github(data)

      expect(user.github_token).to eq(data['credentials']['token'])
      expect(user.github_uid).to eq(data['uid'])
      expect(user.github_handle).to eq(data['extra']['raw_info']['login'])
      expect(user.github_url).to eq(data['info']['urls']['GitHub'])
    end

    it '#get_friend_users & #get_friends_ids & #has_friends' do
      april = create(:user, email: "test@email.com", password: "test", github_handle: "aprildagonese", github_token: ENV['GITHUB_API_KEY'], github_uid: "41272635")
      mackenzie = create(:user, email: "mackenzie@email.com", password: "test", github_handle: "Mackenzie-Frey", github_token: ENV['MF_GITHUB_TOKEN'], github_uid: "42525195")
      zach = create(:user, email: "zach@email.com", password: "test", github_handle: "nagerz", github_token: "faketoken", github_uid: "34927114")

      expect(april.get_friends_ids.count).to eq(0)
      expect(april.has_friends?).to eq(false)

      friendship = create(:friendship, user: april, friend_user: mackenzie)

      expect(april.get_friend_users).to eq([mackenzie])
      expect(april.get_friends_ids.count).to eq(1)
      expect(april.has_friends?).to eq(true)

      friendship = create(:friendship, user: april, friend_user: zach)

      expect(april.get_friend_users).to eq([mackenzie, zach])
      expect(april.get_friends_ids.count).to eq(2)
      expect(april.has_friends?).to eq(true)
    end

    it "#activated?" do
      user1 = create(:user, email_confirmed: false)
      user2 = create(:user, email_confirmed: true)

      expect(user1.activated?).to eq(false)
      expect(user2.activated?).to eq(true)
    end

    it "#email_activate" do
      user = create(:user, email_confirmed: false, confirm_token: "123456")

      user.email_activate

      expect(user.email_confirmed).to eq(true)
      expect(user.confirm_token).to eq(nil)
    end

    context "Tutorials" do
      before :each do
        @april = create(:user, email: "test@email.com", password: "test", github_token: ENV['GITHUB_API_KEY'], github_uid: "41272635", github_handle: 'aprildagonese', github_url: 'https://github.com/aprildagonese')
        @mackenzie = create(:user, email: "mackenzie@email.com", password: "test", github_token: ENV['MF_GITHUB_TOKEN'], github_uid: "42525195")
        @tut1, @tut2, @tut3 = create_list(:tutorial, 3)
        @vid1, @vid2, @vid3 = create_list(:video, 3, tutorial: @tut1)
        @vid4, @vid5, @vid6, @vid7 = create_list(:video, 4, tutorial: @tut2)
        @vid8, @vid9 = create_list(:video, 2, tutorial: @tut3)
        @user_vid1 = create(:user_video, user: @april, video: @vid1)
        @user_vid2 = create(:user_video, user: @april, video: @vid3)
        @user_vid3 = create(:user_video, user: @april, video: @vid5)
        @user_vid4 = create(:user_video, user: @april, video: @vid7)
        @user_vid5 = create(:user_video, user: @mackenzie, video: @vid7)
        @user_vid6 = create(:user_video, user: @mackenzie, video: @vid8)
        @user_vid7 = create(:user_video, user: @mackenzie, video: @vid9)
      end

      it "#my_tutorials" do
        expect(@april.my_tutorials).to eq([@tut1, @tut2])
        expect(@mackenzie.my_tutorials).to eq([@tut2, @tut3])
      end

      it "#my_tutorial_videos" do
        expect(@april.my_tutorial_videos(@tut1)).to eq([@vid1, @vid3])
        expect(@april.my_tutorial_videos(@tut2)).to eq([@vid5, @vid7])
        expect(@mackenzie.my_tutorial_videos(@tut2)).to eq([@vid7])
        expect(@mackenzie.my_tutorial_videos(@tut3)).to eq([@vid8, @vid9])
      end
    end
  end

  context 'class methods' do
    it '.is_user?' do
      mackenzie = create(:user, email: "mackenzie@email.com", password: "test", github_token: ENV['MF_GITHUB_TOKEN'], github_uid: "42525195")

      real_user_data = {"provider"=>"github", "uid"=>"42525195",
        "credentials"=>{"token"=>"#{ENV['OAUTH_TEST_TOKEN']}", "expires"=>false}}

      non_user_data = {"provider"=>"github", "uid"=>"29572047",
        "credentials"=>{"token"=>"#{ENV['OAUTH_TEST_TOKEN']}", "expires"=>false}}


      expect(User.is_user?(real_user_data["uid"])).to eq(true)
      expect(User.is_user?(non_user_data["uid"])).to eq(false)
    end
  end
end
