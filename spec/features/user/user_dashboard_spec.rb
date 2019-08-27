require 'rails_helper'
  describe 'As a logged in user' do
    before :each do
      user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

  describe 'When I visit /dashboard' do
    it "I am taken to my user dashboard and I see a section for github" do
    visit dashboard_path
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Github")
    expect(page).to have_button("Connect to Github")

    stub_omniauth
    stub_info("http://api.github.com/user/repos", "./fixtures/repos.json")
    binding.pry
    click_on("Connect to Github")
    stub_info("http://api.github.com/user/followers", "./fixtures/followers.json")
    stub_info("http://api.github.com/user/following", "./fixtures/following.json")
    expect(page).to not_have_button("Connect to Github")
    end
  end
end
