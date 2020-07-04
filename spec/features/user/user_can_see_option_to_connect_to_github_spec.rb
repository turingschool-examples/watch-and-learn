require 'rails_helper'

describe "As a user" do
  it "shows a link to connect to github on dashboard" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit '/dashboard'

    expect(page).to have_link("Connect to Github")
  end

end
