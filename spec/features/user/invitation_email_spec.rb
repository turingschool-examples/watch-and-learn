require 'rails_helper'

describe 'a registered user on the dashboard page' do
  it 'can invite someone with a github handle to the account' do
    user_1 = create(:user, github_token: ENV["GITHUB_API_KEY"])
    github_handle = 'stoic-plus'
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    VCR.use_cassette("services/find_repositories") do
      VCR.use_cassette("services/find_followers") do
        VCR.use_cassette("services/find_followings") do
          visit dashboard_path
        end
      end
    end
    expect(page).to have_link('Send an Invite')

    click_on 'Send an Invite'

    expect(current_path).to eq(new_invite_path)

    fill_in :invite_github_handle, with: github_handle

    VCR.use_cassette("services/find_email") do
      VCR.use_cassette("services/find_repositories") do
        VCR.use_cassette("services/find_followers") do
          VCR.use_cassette("services/find_followings") do
            click_on 'Send Invite'
          end
        end
      end
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Successfully sent invite!')
    expect(page).to_not have_content("The Github user you selected doesn't have an email address associated with their account.")
  end
end
