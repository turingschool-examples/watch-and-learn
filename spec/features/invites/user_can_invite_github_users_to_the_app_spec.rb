require 'rails_helper'
feature 'A logged in user send invites to app to github users' do
    before :each do
    user = create(:user)
    user.validate_user
    user.github_value.token = "bec34030f3554ddd4644040c92258af325b65ef9"
    stub_omniauth
    stub_info('http://localhost:3000/auth/github/callback', "./fixtures/tokens_fixture.json")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path
    click_on "Connect to Github"
  end

  scenario 'by clicking send invite button and is redirected to the invite path ' do
    expect(current_path).to eq(dashboard_path)
    save_and_open_page
    click_on("Send an Invite")
    expect(current_path).to eq(invite_path)
    fill_in'handle', with: "wthompson92"
    click_on("Send Invite")

  end
end
