require 'rails_helper'

describe "User" do
  it 'can see a list of following' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    VCR.use_cassette("following") do
      visit '/dashboard'

      expect(page).to have_css("#following")
      expect(page).to have_content("Following")

      within "#following" do
        expect(page).to have_css(".user")
        within(first(".user")) do
          expect(page).to have_css(".handle")
        end

        url = "https://github.com/timnallen"
        expect(page).to have_link("timnallen", href: url)
      end
    end
  end
end
