require 'rails_helper'

describe "as a signed in user" do
  WebMock.allow_net_connect!
  VCR.turn_off!
  VCR.eject_cassette

  it "can see five of its github repos on the dashboard" do
    user = create(:user, token: '')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    within ".github" do
      expect(page).to have_content('Github Repositories')
      expect(page).to have_css(".repos", count: 5)

      within (first(".repos")) do
        expect(page).to have_link("monster_shop_part_1")
      end
    end
  end
end
