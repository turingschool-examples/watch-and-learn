require 'rails_helper'

describe "as a signed in user" do
  WebMock.allow_net_connect!
  VCR.turn_off!
  VCR.eject_cassette

  xit "can see five of its github repos on the dashboard" do
    user = create(:user, token: '')
    user2 = create(:user, token: '')

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

  xit "only shows one user's github" do
    user = create(:user, token: '')
    user2 = create(:user, token: '')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    within ".github" do
      save_and_open_page
      expect(page).to have_content('Github Repositories')
      expect(page).to have_css(".repos", count: 5)

      within (first(".repos")) do
        expect(page).to have_link("monster_shop_part_1")
        expect(page).not_to have_link("adopt_dont_shop_part_two")
      end
    end
  end

  it "only shows a tokened user's github" do
    user3 = create(:user, token: nil)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user3)

    visit '/dashboard'

    expect(page).not_to have_css(".github")
  end
end
