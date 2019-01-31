require 'rails_helper'

describe 'vister can create an account', :js do
  before(:each) do
    @email = 'jimbob@aol.com'
    @first_name = 'Jim'
    @last_name = 'Bob'
    @password = 'password'
    @password_confirmation = 'password'

    visit '/'
  end

  it 'signs up from the sign_in link' do
    click_on 'Sign In'

    click_on 'Sign up now.'

    expect(current_path).to eq(register_path)

    fill_in 'user[email]', with: @email
    fill_in 'user[first_name]', with: @first_name
    fill_in 'user[last_name]', with: @last_name
    fill_in 'user[password]', with: @password
    fill_in 'user[password_confirmation]', with: @password

    click_on'Create Account'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content(@email)
    expect(page).to have_content(@first_name)
    expect(page).to have_content(@last_name)
    expect(page).to_not have_content('Sign In')
  end

  it 'signs up from the register link' do
    click_on 'Register'

    expect(current_path).to eq(register_path)

    fill_in 'user[email]', with: @email
    fill_in 'user[first_name]', with: @first_name
    fill_in 'user[last_name]', with: @last_name
    fill_in 'user[password]', with: @password
    fill_in 'user[password_confirmation]', with: @password

    click_on'Create Account'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Logged in as #{@first_name}")
    expect(page).to have_content("This account has not yet be activated. Please check your email")
    expect(page).to have_content(@email)
    expect(page).to have_content(@first_name)
    expect(page).to have_content(@last_name)
    expect(page).to_not have_content('Sign In')
  end

  it 'activates new user through email' do
    create(:user, activated: false)

    visit dashboard_path

    clear_email
  end
end
