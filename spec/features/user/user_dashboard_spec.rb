require 'rails_helper'
describe 'As a logged in user' do
  before :each do
    @user = User.create!(email: "will@gmail.com", first_name: "Will", last_name: "Thompson", password: "password")


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    @user.validate_user
    stub_omniauth
    stub_info('http://localhost:3000/auth/github/callback', "./fixtures/tokens_fixture.json")
    stub_info("https://api.github.com/user/repos", "./fixtures/repos.json")
    stub_info("https://api.github.com/user/followers", "./fixtures/followers.json")
    stub_info("https://api.github.com/user/following", "./fixtures/following.json")
    @user.github_value.create!(token: ENV['my_token'])

  end

  describe 'When I visit /dashboard' do
    it "I am taken to my user dashboard and I see a section for github" do
      visit dashboard_path
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Github")
      expect(page).to have_button("Connect to Github")

    end


    it "has a list of all repos" do
      visit dashboard_path
      click_on "Connect to Github"
      save_and_open_page
      expect(page).to have_no_button("Connect to Github")
      expect(page).to have_content("little_shop")
      expect(page).to have_content("git_pairing_practice")
      expect(page).to have_content("1904_m2_mid_mod")
      expect(page).to have_content("activerecord-obstacle-course")
    end

    it "has a list of all followers" do
      visit dashboard_path
      click_on "Connect to Github"
      expect(page).to have_no_button("Connect to Github")
      expect(page).to have_content("dphilla")
    end

    it "has a list of all the users the current_user is following" do
      visit dashboard_path
      click_on "Connect to Github"
      expect(page).to have_no_button("Connect to Github")
      expect(page).to have_content("dphilla")
      expect(page).to have_content("o-hill")
    end

    it "has a list of all the users the current_user is friends with" do
      visit dashboard_path
      click_on "Connect to Github"

      expect(page).to have_content("faker92")
    end
  end
end
