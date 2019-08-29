require 'rails_helper'

describe 'visitor can create an account' do
  it 'and activate upon clicking link in email' do
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

    click_on 'Create Account'

    user = User.last

    visit "/users/#{user.id}/activated"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Thanks! Your account is activated!")
    # binding.pry
    expect(page).to have_content("Status: Active")
  end
end
