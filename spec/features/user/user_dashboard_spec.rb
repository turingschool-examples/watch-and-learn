require 'rails_helper'
  describe 'As a logged in user' do
    before :each do
      user = create(:user)
      stub_omniauth
      stub_info('http://localhost:3000/auth/github/callback', "./fixtures/tokens_fixture.json")
      stub_info("https://api.github.com/user/repos", "./fixtures/repos.json")
      stub_info("https://api.github.com/user/followers", "./fixtures/followers.json")
      stub_info("https://api.github.com/user/following", "./fixtures/following.json")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

  describe 'When I visit /dashboard' do
    it "I am taken to my user dashboard and I see a section for github" do
      visit dashboard_path
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Github")
    expect(page).to have_button("Connect to Github")
    click_on("Connect to Github")

    expect(page).to have_no_button("Connect to Github")

    end
  end
end
