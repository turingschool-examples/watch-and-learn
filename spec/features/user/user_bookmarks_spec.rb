require 'rails_helper'

describe "As a Logged in User" do
  it "can display things that are bookmarked" do
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
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    within(".bookmarks") do
      within(all(".bookmark")[0]) do
        expect(page).to have_content(video_3.title)
      end
      within(all(".bookmark")[1]) do
        expect(page).to have_content(video_4.title)
      end
      within(all(".bookmark")[2]) do
        expect(page).to have_content(video_2.title)
      end
      within(all(".bookmark")[3]) do
        expect(page).to have_content(video_1.title)
      end
    end
  end
end
