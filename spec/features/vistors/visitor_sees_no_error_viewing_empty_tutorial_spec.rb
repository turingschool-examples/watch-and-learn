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
end