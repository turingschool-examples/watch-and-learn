require 'rails_helper'

RSpec.describe "For registered User" do
  before(:each) do
    @tutorial = create(:tutorial, classroom: true)
    @video = create(:video, tutorial: @tutorial)

    @tutorial_2 = create(:tutorial)
    @video_2 = create(:video, tutorial: @tutorial_2)
  end

  it "#can see video with marked classroom content" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorials_path

    expect(page).to have_content(@tutorial.title)
    expect(page).to have_content(@tutorial_2.title)
  end

  it "#can't see video whith marked classroom content" do

    visit tutorials_path

    expect(page).to have_content(@tutorial_2.title)
    expect(page).to_not have_content(@tutorial.title)

  end
end