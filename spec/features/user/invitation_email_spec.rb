require 'rails_helper'

describe 'a registered user on the dashboard page' do
  it 'cannot invite someone if your github is not connected' do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(page).to_not have_link("Send an Invite")
  end

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

    VCR.use_cassette("services/find_invitee") do
      VCR.use_cassette("services/find_inviter") do
        VCR.use_cassette("services/find_repositories") do
          VCR.use_cassette("services/find_followers") do
            VCR.use_cassette("services/find_followings") do
              click_on 'Send Invite'
            end
          end
        end
      end
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Successfully sent invite!')
    expect(page).to_not have_content("The Github user you selected doesn't have an email address associated with their account.")

    open_email("ricardoledesmadev@gmail.com")
    expect(current_email).to have_content("Hello Ricardo Ledesma, Justin Mauldin has invited you to join Turing Tutorials. You can create an account")
    current_email.click_link("Click here to create your account")

    expect(current_path).to eq(get_started_path)
    expect(page).to have_content("Get Started")
    click_link("Register")
    expect(current_path).to eq(register_path)
  end

  it "Gives an error message if there is no email found for that github user" do
    user_1 = create(:user, github_token: ENV["GITHUB_API_KEY"])
    github_handle = 'Bradniedt'
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    VCR.use_cassette("services/find_repositories") do
      VCR.use_cassette("services/find_followers") do
        VCR.use_cassette("services/find_followings") do
          visit dashboard_path
        end
      end
    end

    click_on 'Send an Invite'

    fill_in :invite_github_handle, with: github_handle

    VCR.use_cassette("services/find_invitee_no_email") do
      VCR.use_cassette("services/find_inviter") do
        VCR.use_cassette("services/find_repositories") do
          VCR.use_cassette("services/find_followers") do
            VCR.use_cassette("services/find_followings") do
              click_on 'Send Invite'
            end
          end
        end
      end
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to_not have_content('Successfully sent invite!')
    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end
end
