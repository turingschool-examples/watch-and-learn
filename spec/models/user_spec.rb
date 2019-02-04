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
  describe 'class methods' do
    it '.user_in_database' do
      user_1 = create(:user)
      expect(User.user_in_database(user_1.github_username)).to eq(user_1)
    end
  end
  describe 'instance methods' do
    it '#user_not_friend' do
      user_1 = create(:user)
      user_2 = create(:user)
      expect(user_1.user_not_friend(user_2.github_username)).to eq(true)
      user_3 = create(:user, friends: [user_1])
      expect(user_3.user_not_friend(user_1.github_username)).to eq(false)
    end
    it '#bookmarks' do
      prework_tutorial_data = {
        "title"=>"Back End Engineering - Prework",
        "description"=>"Videos for prework.",
        "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
        "playlist_id"=>"PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5",
        "classroom"=>false,
      }
      prework_tutorial = Tutorial.create! prework_tutorial_data

      video_2 = prework_tutorial.videos.create!({
        "title"=>"Prework - SSH Key Setup",
        "description"=> Faker::Hipster.paragraph(2, true),
        "video_id"=>"XsPVWGKK0qI",
        "thumbnail"=>"https://i.ytimg.com/vi/XsPVWGKK0qI/hqdefault.jpg",
        "position"=>2
      })
      mod_1_tutorial_data = {
        "title"=>"Back End Engineering - Module 1",
        "description"=>"Videos related to Mod 1.",
        "thumbnail"=>"https://i.ytimg.com/vi/tZDBWXZzLPk/hqdefault.jpg",
        "playlist_id"=>"PL1Y67f0xPzdNsXqiJs1s4NlpI6ZMNdMsb",
        "classroom"=>false,
      }

      m1_tutorial = Tutorial.create! mod_1_tutorial_data

      video_3 = m1_tutorial.videos.create!({
        "title"=>"Flow Control in Ruby",
        "description"=> Faker::Hipster.paragraph(2, true),
        "video_id"=>"tZDBWXZzLPk",
        "thumbnail"=>"https://i.ytimg.com/vi/tZDBWXZzLPk/hqdefault.jpg",
        "position"=>1
      })
      video_4 = m1_tutorial.videos.create!({
        "title"=>"How to use SimpleCov",
        "description"=> Faker::Hipster.paragraph(2, true),
        "video_id"=>"WMgDD2lU5nY",
        "thumbnail"=>"https://i.ytimg.com/vi/WMgDD2lU5nY/hqdefault.jpg",
        "position"=>2
      })
      video_5 = m1_tutorial.videos.create!({
        "title"=>"Customizing JSON in your API",
        "description"=> Faker::Hipster.paragraph(2, true),
        "video_id"=>"cv1VQ_9OqvE",
        "thumbnail"=>"https://i.ytimg.com/vi/cv1VQ_9OqvE/hqdefault.jpg",
        "position"=>1
      })

      video_1 = prework_tutorial.videos.create!({
        "title"=>"Prework - Environment Setup",
        "description"=> Faker::Hipster.paragraph(2, true),
        "video_id"=>"qMkRHW9zE1c",
        "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
        "position"=>5
      })

      user = create(:user, token: ENV["GITHUB_API_KEY"])
      UserVideo.create!(user_id: user.id, video_id: video_2.id)
      UserVideo.create!(user_id: user.id, video_id: video_1.id)
      UserVideo.create!(user_id: user.id, video_id: video_3.id)
      UserVideo.create!(user_id: user.id, video_id: video_4.id)

      expect(user.bookmarks).to eq([video_3, video_4, video_2, video_1])
    end
  end
end
