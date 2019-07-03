require 'rails_helper'

feature 'user can see github repos' do
  before :each do
    @user = create(:user)
    @user_with_token = create(:user, token: "a343434234324t3r")
  end

  scenario 'it can login and see repos with token' do
    VCR.use_cassette("services/github_service") do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_with_token)

      visit '/dashboard'

      expect(current_path).to eq('/dashboard')
      expect(page).to have_css('#github')

      within('#github') do
        page.assert_selector('.repo', count: 5)
        within(first('.repo')) do
          expect(page).to have_content('test_user/repo1')
        end
      end
    end
  end

  scenario 'it can login and will not see repos without token' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit '/dashboard'

    expect(current_path).to eq('/dashboard')
    expect(page).to_not have_css('#github')
  end
end
