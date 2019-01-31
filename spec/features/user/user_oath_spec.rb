require 'rails_helper'

describe "User Oath funtionality" do
  it "can see a link" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/dashboard"

    expect(page).to have_link("Connect to Github")
  end
end
