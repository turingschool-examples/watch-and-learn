require 'rails_helper'

describe "When a Logged In User, who does not have a Github Access Token" do
  it "they cannot see a section for 'Github, nor any 'Github repo's" do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to_not have_content("Github Repo's")
  end
end
