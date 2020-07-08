require 'rails_helper'

describe 'User' do
  before do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit "/dashboard"
  end

  it 'user can send invite to ghub users that have emails' do
    click_link "Send an Invite"
    expect(current_path).to eq("/invite")

    within ".invite-form" do
      fill_in 'Github Handle', with: "Gallup93"
      click_on 'Send Invite'
    end

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Successfully sent invite!")
  end

  it 'user cannot send invite to ghub users without a listed emails' do
    click_link "Send an Invite"
    expect(current_path).to eq("/invite")

    within ".invite-form" do
      fill_in 'Github Handle', with: "whitneykidd"
      click_on 'Send Invite'
    end

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end
end
