require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe "#instance methods" do
    it 'update_positions' do
      prework_tutorial_data = {
        "title"=>"Back End Engineering - Prework",
        "description"=>"Videos for prework.",
        "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
        "playlist_id"=>"PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5",
        "classroom"=>false,
      }
      prework_tutorial = Tutorial.create! prework_tutorial_data

      video_1 = prework_tutorial.videos.create!({
        "title"=>"Prework - Environment Setup",
        "description"=> Faker::Hipster.paragraph(2, true),
        "video_id"=>"qMkRHW9zE1c",
        "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
        "position"=>1
      })
      video_2 = prework_tutorial.videos.create!({
        "title"=>"Prework - SSH Key Setup",
        "description"=> Faker::Hipster.paragraph(2, true),
        "video_id"=>"XsPVWGKK0qI",
        "thumbnail"=>"https://i.ytimg.com/vi/XsPVWGKK0qI/hqdefault.jpg",
        "position"=>0
      })
      video_3 = prework_tutorial.videos.create!({
        "title"=>"Prework - Strings",
        "description"=> Faker::Hipster.paragraph(2, true),
        "video_id"=>"iXLwXvev4X8",
        "thumbnail"=>"https://i.ytimg.com/vi/iXLwXvev4X8/hqdefault.jpg",
        "position"=>0
      })
      video_4 = prework_tutorial.videos.create!({
        "title"=>"Prework - Arrays",
        "description"=> Faker::Hipster.paragraph(2, true),
        "video_id"=>"c2UnIQ3LRnM",
        "thumbnail"=>"https://i.ytimg.com/vi/c2UnIQ3LRnM/hqdefault.jpg",
        "position"=>4
      })

      prework_tutorial.update_positions

      expect(video_2.position).to eq(5)
      expect(video_3.position).to eq(6)
    end
  end
end
