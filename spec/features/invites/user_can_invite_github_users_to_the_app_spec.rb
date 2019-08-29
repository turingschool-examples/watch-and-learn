require 'rails_helper'

feature 'A logged in user send invites to app to github users' do
    before :each do
    user = create(:user)
    user.github_value.token =

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path
  end

  scenario 'by clicking send invite button and is redirected to the invite path ' do
    expect(current_path).to eq(dashboard_path)
    click_on("Send an Invite")
    expect(current_path).to eq(invite_path)
    fill_in'handle', with: "wthompson92"
    click_on("Send Invite")
    save_and_open_page
  end
end
