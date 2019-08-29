require 'rails_helper'

describe 'vister can create an account' do
  it ' visits the home page' do
    stub_dashboard_api_calls

    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'

    click_on 'Sign In'

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password




  end
end


# As a non-activated user
# When I check my email for the registration email
# I should see a message that says ""
# And when I click on that link
# Then I should be taken to a page that says "Thank you! Your account is now
# activated."
#
# And when I visit "/dashboard"
# Then I should see "Status: Active"
