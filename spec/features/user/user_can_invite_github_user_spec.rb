require 'rails_helper'

describe 'A registered user' do
  before :each do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end
  it 'can invite someone from github to the app' do
    @user.update(github_token: ENV["GITHUB_TOKEN_A"], github_username: ENV["GITHUB_USERNAME_A"])

    visit dashboard_path
    click_button "Send an Invite"

    expect(current_path).to eq(invite_path)

    fill_in :github_username, with: ENV["GITHUB_USERNAME_B"]
    click_button "Send Invite"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Successfully sent invite!")

    invitation_email = ActionMailer::Base.deliveries.last

    expect(invitation_email.text_part.body).to have_content("Hello #{ENV["GITHUB_USERNAME_B"]}")
    expect(invitation_email.text_part.body).to have_content("#{ENV["GITHUB_USERNAME_A"]} has invited you to join Secure Fjord. You can create an account here")

  end

  it "has a sad path if github user doesn't make email available" do
    @user.update(github_token: ENV["GITHUB_TOKEN_B"], github_username: ENV["GITHUB_USERNAME_B"])

    visit dashboard_path
    click_button "Send an Invite"

    expect(current_path).to eq(invite_path)

    fill_in :github_username, with: ENV["GITHUB_USERNAME_A"]
    click_button "Send Invite"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end

  it "has a sad path if an invalid github username is invited" do
    @user.update(github_token: ENV["GITHUB_TOKEN_B"], github_username: ENV["GITHUB_USERNAME_B"])

    visit dashboard_path
    click_button "Send an Invite"

    expect(current_path).to eq(invite_path)

    fill_in :github_username, with: "Imprettysurethisisntavalidgithubname"
    click_button "Send Invite"

    expect(current_path).to eq(invite_path)
    expect(page).to have_content("There is no Github user with that username.")
  end
end
