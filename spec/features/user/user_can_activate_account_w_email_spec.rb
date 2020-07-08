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

# As a guest user
# When I visit "/"
# And I click "Register"
# Then I should be on "/register"
# And when I fill in an email address (required)
# And I fill in first name (required)
# And I fill in last name (required)
# And I fill in password and password confirmation (required)
# And I click submit
# Then I should be redirected to "/dashboard"
# And I should see a message that says "Logged in as <SOME_NAME>"
# And I should see a message that says "This account has not yet been activated. Please check your email."
# Background: The registration process above will trigger this story
#
# As a non-activated user
# When I check my email for the registration email
# I should see a message that says "Visit here to activate your account."
# And when I click on that link
# Then I should be taken to a page that says "Thank you! Your account is now activated."
#
# And when I visit "/dashboard"
# Then I should see "Status: Active"
