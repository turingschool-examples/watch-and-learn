require 'rails_helper'

describe "users logged in see different tutorials" do
  before(:each) do
    @classroom_tutorial_data = {
      "title"=>"Back End Engineering - Module 3",
      "description"=>"Video content for Mod 3.",
      "thumbnail"=>"https://i.ytimg.com/vi/R5FPYQgB6Zc/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdOq2FcpWnawJeyJ3ELUdBkJ",
      "classroom"=>true,
      "tag_list"=>["Internet", "BDD", "Ruby"],
    }
    @public_tutorial_data = {
      "title"=>"Public",
      "description"=>"Public",
      "thumbnail"=>"https://i.ytimg.com/vi/R5FPYQgB6Zc/hqdefault.jpg",
      "playlist_id"=>"PL1Y67f0xPzdOq2FcpWnawJeyJ3ELUdBkJ",
      "classroom"=>false,
      "tag_list"=>["Internet", "BDD", "Ruby"],
    }
    @classroom = Tutorial.create(@classroom_tutorial_data)
    @public = Tutorial.create(@public_tutorial_data)
    @user1 = create(:user)
  end

  it "as a visitor I don't see tutorials labled classroom" do
    visit "/"
    within('.tutorials') do
      expect(page).to have_content(@public.title)
      expect(page).to have_no_content(@classroom.title)
    end
  end

  it "as a user I see all tutorials" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

    visit "/"
    within('.tutorials') do
      expect(page).to have_content(@public.title)
      expect(page).to have_content(@classroom.title)
    end
  end
end
