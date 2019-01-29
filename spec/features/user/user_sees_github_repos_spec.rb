require 'rails_helper'

describe 'User Dashboard' do
  context "when logged in with github credentials" do
    before :each do
      # stub_request(:get, "https://api.github.com/user/repos").
      #   with(headers: { 'Authorization' => "token #{ENV["GITHUB_API_KEY"]}" })
      #
      # uri = URI.parse("https://api.github.com/user/repos")
      # req = Net::HTTP::Get.new(uri.path)
      # req['Authorization'] = "token #{ENV["GITHUB_API_KEY"]}"
      #
      # res = Net::HTTP.start(uri.host) do |http|
      #   binding.pry
      #   http.request(req, "abc")
      # end
      #
      # binding.pry
      user = create(:user, github_key: ENV["GITHUB_API_KEY"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
    it 'has Github section' do
      visit dashboard_path

      within ".github" do
        expect(page).to have_content("Github")
        within ".repositories" do
          expect(page).to have_css(".repository", count: 5)
        end
      end
    end
    xit 'links to repos from repo names' do
      visit dashboard_path


    end
  end
end
