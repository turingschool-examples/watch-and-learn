require 'rails_helper'

feature "User" do
    before :each do
      user = create(:user)
			user.token = Token.create(github_token: ENV["GITHUB_API_KEY"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
		end

	context "As a logged in user when I visit my dashboard " do
		it 'shows a section of followers with handles as links to github' do
			VCR.use_cassette("github/dashboard", allow_playback_repeats: true) do
      	visit dashboard_path
      	expect(page).to have_selector(".github_section")
					
	  		within ".github_section" do
					expect(page).to have_link("Loomus")
					expect(page).to have_link("ryanmillergm")
				end
			end
		end	
	end
end
