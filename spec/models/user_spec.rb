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
      april = create(:user, email: "test@email.com", password: "test", github_token: ENV['GITHUB_API_KEY'], github_uid: "41272635")
      mackenzie = create(:user, email: "mackenzie@email.com", password: "test", github_token: ENV['MF_GITHUB_TOKEN'], github_uid: "42525195")
      zach = create(:user, email: "zach@email.com", password: "test", github_token: "faketoken", github_uid: "34927114")

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
