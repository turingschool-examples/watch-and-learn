require 'rails_helper'


feature "Github Repository edge case testing" do
	before :each do 
		@user_1 = create(:user)
		@token_1 = @user_1.token.create(github_token: ENV['GITHUB_API_KEY']

		@user_2 = create(:user)
		@token_2 = @user_1.token.create(github_token: ENV['GITHUB_API_KEY_2']

		@user_3 = create(:user)
	end 

	scenario "user_1 returns expected repositories" do
		VCR.use_cassete("github/edgecase_repositories_1") do	
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

			visit dashboard_path	
			within ".github_section" do
				expect(page).to have_link("battleship_explosion")
			end
		end
	end

	scenario "user_2 returns expected repositories" do
		VCR.use_cassete("github/edgecase_repositories_2") do 	
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)

			visit dashboard_path	
			within ".github_section" do
				expect(page).to have_link("book_club")
			end
		end
	end

	
	scenario "user_3 returns no repositories" do
		VCR.use_cassete("github/edgecase_repositories_3") do	
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_3)

			visit dashboard_path	
			expect(page).to_not have_selector(".github_section")
		end
	end
end
