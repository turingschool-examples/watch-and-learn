require 'rails_helper'

describe 'A registered user' do
  it 'can see github following' do
    user_2 = create(:user)
    user_2.update(github_token: ENV["GITHUB_TOKEN_B"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)
    visit dashboard_path

    expect(page).to have_content("Github")
    within ".github" do
      expect(page).to have_content("Following")
      expect(page).to have_link(ENV["GITHUB_USERNAME_A"])
    end

  end
end
