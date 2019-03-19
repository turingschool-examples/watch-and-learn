require 'rails_helper'

describe'when I visit my dashboard' do
  context 'as a user' do
    before :each do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(User).to receive(:github_token).and_return(ENV['GITHUB_API_KEY'])
    end

    it 'I see a section for github' do
      VCR.use_cassette("user/dashboard_github_request") do
        visit dashboard_path

        within "#github" do
          expect(page).to have_content("Github")
        end
      end
    end

    it 'Within the github section I see a list of five repos linking to github' do
      VCR.use_cassette("user/dashboard_github_request") do
        visit dashboard_path

        within "#github" do
          expect(page).to have_css(".repo", count: 5)
          expect(page).to have_link 'battleship'
          expect(page).to have_link 'little_shop'
          expect(page).to have_link 'brownfield-of-dreams'
        end
      end
    end
    it 'shows me a list of my github followers' do
      VCR.use_cassette("user/dashboard_github_follower_request") do
        visit dashboard_path

        within '#github' do
          expect(page).to have_content('Followers')

          within '#followers' do
            expect(page).to have_css(".follower")
            expect(page).to have_link('plapicola')
            expect(page).to have_link('m-mrcr')
            expect(page).to have_link('n-flint')
          end
        end
      end
    end
  end
end
