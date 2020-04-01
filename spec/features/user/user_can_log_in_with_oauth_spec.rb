require 'rails_helper'

RSpec.describe 'Log in with OAuth' do

  it "user without token can see button to connect to github" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(user.github_token).to eq(nil)
    expect(page).to_not have_css(".github")
    expect(page).to have_link("Connect to GitHub")
  end

  it "user without token can connect to github and see all the information" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    stub_to_test_omniauth

    click_on("Connect to GitHub")

    expect(user.github_token).to_not eq(nil)
    expect(page).to_not have_link("Connect to GitHub")
    expect(page).to have_css(".github")
  end

end
