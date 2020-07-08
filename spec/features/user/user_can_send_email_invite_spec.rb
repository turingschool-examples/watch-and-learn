require 'rails_helper'

describe "as a registered user" do
  it "will send the user an invite", :vcr do

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_on "Send an Invite"
    expect(current_path).to eq("/invite")

  end
end
