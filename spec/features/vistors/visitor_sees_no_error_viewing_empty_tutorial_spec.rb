require 'rails_helper'

describe 'as a user or visitor' do
  it 'sees no error when viewing empty tutorial show page' do
    prework_tutorial_data = {
      "title"=>"Back End Engineering - Prework",
      "description"=>"Videos for prework.",
      "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5",
      "classroom"=>false,
    }
    tutorial_1 = Tutorial.create! prework_tutorial_data

    tutorial_1.videos.create!({
      "title"=>"Prework - Environment Setup",
      "description"=> Faker::Hipster.paragraph(2, true),
      "video_id"=>"qMkRHW9zE1c",
      "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
      "position"=>1
    })
    mod_1_tutorial_data = {
      "title"=>"Back End Engineering - Module 1",
      "description"=>"Videos related to Mod 1.",
      "thumbnail"=>"https://i.ytimg.com/vi/tZDBWXZzLPk/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdNsXqiJs1s4NlpI6ZMNdMsb",
      "classroom"=>false,
    }

    tutorial_2 = Tutorial.create! mod_1_tutorial_data

    visit "/tutorials/#{tutorial_2.id}"
    expect(page.status_code).to eq(200)
    expect(page).to have_content(tutorial_2.title)
  end
  it 'updates default position values and doesnt error out' do
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

    visit "/tutorials/#{prework_tutorial.id}"

    expect(page.status_code).to eq(200)
    expect(Video.second.position).to eq(5)
    expect(Video.third.position).to eq(6)
  end
end
