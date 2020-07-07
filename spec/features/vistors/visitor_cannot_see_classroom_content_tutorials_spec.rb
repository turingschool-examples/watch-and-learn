require 'rails_helper'

describe 'visitor visits welcome page' do
  it 'I cannot see tutorials labeled classroom content' do
    tutorial1 = {
      "title"=>"tutorial 1",
      "description"=>"Videos for prework.",
      "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5",
      "classroom"=>false,
    }

    tutorial2 = {
      "title"=>"tutorial 2",
      "description"=>"Videos for prework.",
      "thumbnail"=>"https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdN6C-LPuTQ5yzlBoz2joWa5",
      "classroom"=> true,
    }

    visit root_path

    within(first('.tutorials')) do
      expect(page).to have_content(tutorial1.title)
      expect(page).to have_content(tutorial1.description)

      expect(page).to have_no_content(tutorial2.title)
      expect(page).to have_no_content(tutorial2.description)
    end
  end
end