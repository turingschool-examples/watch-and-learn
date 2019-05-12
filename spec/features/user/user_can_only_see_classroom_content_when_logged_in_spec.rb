require 'rails_helper'

describe 'As a logged in user' do
  it 'shows classroom only content' do
    prework_tutorial_data = {
      "title"=>"Back End Engineering - Prework",
      "description"=>"Videos for prework.",
      "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5",
      "classroom"=>true,
    }
    prework_tutorial = Tutorial.create! prework_tutorial_data

    prework_tutorial.videos.create!({
      "title"=>"Prework - Environment Setup",
      "description"=> Faker::Hipster.paragraph(2, true),
      "video_id"=>"qMkRHW9zE1c",
      "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
      "position"=>1
    })
    prework_tutorial.videos.create!({
      "title"=>"Prework - SSH Key Setup",
      "description"=> Faker::Hipster.paragraph(2, true),
      "video_id"=>"XsPVWGKK0qI",
      "thumbnail"=>"https://i.ytimg.com/vi/XsPVWGKK0qI/hqdefault.jpg",
      "position"=>2
    })
    prework_tutorial.videos.create!({
      "title"=>"Prework - Strings",
      "description"=> Faker::Hipster.paragraph(2, true),
      "video_id"=>"iXLwXvev4X8",
      "thumbnail"=>"https://i.ytimg.com/vi/iXLwXvev4X8/hqdefault.jpg",
      "position"=>3
    })
    prework_tutorial.videos.create!({
      "title"=>"Prework - Arrays",
      "description"=> Faker::Hipster.paragraph(2, true),
      "video_id"=>"c2UnIQ3LRnM",
      "thumbnail"=>"https://i.ytimg.com/vi/c2UnIQ3LRnM/hqdefault.jpg",
      "position"=>4
    })

    visit tutorials_path

    expect(page).to_not have_content("Back End Engineering - Prework")

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorials_path

    expect(page).to have_content("Back End Engineering - Prework")
  end
end
