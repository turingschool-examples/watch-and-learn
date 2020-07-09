require 'rails_helper'

describe 'as a visitor I can register and get an email' do
  it 'activates the account' do
    visit root_path
    click_link 'Register'

    expect(current_path).to eq(register_path)
    fill_in :user_email, with: "fake@email.com"
    fill_in :user_first_name, with: "John Jacob"
    fill_in :user_last_name, with: "Jingleheimerschmidt"
    fill_in :user_password, with: "hisnameismynametoo"
    fill_in :user_password_confirmation, with: "hisnameismynametoo"

    click_on "Create Account"
    expect(current_path).to eq(dashboard_path)
    new_user = User.last
    expect(new_user.activated).to eq(false)
    expect(page).to have_content("Logged in as John Jacob Jingleheimerschmidt")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")

    activation_email = ActionMailer::Base.deliveries.last

    expect(activation_email.text_part.body).to have_content("Visit here to activate account:")
    expect(activation_email.text_part.body).to have_content(user_activate_path(new_user))

    visit(user_activate_path(new_user))
    expect("Thank you! Your account is now activated.")
    expect(User.find(new_user.id).activated).to eq(true)

    visit(dashboard_path)
    expect(page).to have_content("Status: Active")
  end
end
