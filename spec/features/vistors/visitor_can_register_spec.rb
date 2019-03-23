require 'rails_helper'

describe 'vister can create an account', :js do
  before :each do
    @email = 'jimbob@aol.com'
    @first_name = 'Jim'
    @last_name = 'Bob'
    @password = 'password'
    @password_confirmation = 'password'
  end

  it 'when providing valid information' do
    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: @email
    fill_in 'user[first_name]', with: @first_name
    fill_in 'user[last_name]', with: @last_name
    fill_in 'user[password]', with: @password
    fill_in 'user[password_confirmation]', with: @password

    click_on 'Create Account'

    expect(current_path).to eq(validation_landing_path)
    expect(page).to have_content("Your account has been created.")
    expect(page).to have_content("Please check your email to validate your account.")
  end

  it 'visitors cannot register with invalid information' do
    visit new_user_path

    click_button 'Create Account'

    expect(page).to have_content('There are problems with the provided information.')
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Password can't be blank")
  end

  it 'visitors cannot register with non-matching password confirmations' do
    visit new_user_path

    fill_in 'user[email]', with: @email
    fill_in 'user[first_name]', with: @first_name
    fill_in 'user[last_name]', with: @last_name
    fill_in 'user[password]', with: @password
    fill_in 'user[password_confirmation]', with: "secret"

    click_on 'Create Account'

    expect(page).to have_content "Password confirmation doesn't match"
  end

  it 'receives an activation email when registering' do
    visit new_user_path

    fill_in 'user[email]', with: @email
    fill_in 'user[first_name]', with: @first_name
    fill_in 'user[last_name]', with: @last_name
    fill_in 'user[password]', with: @password
    fill_in 'user[password_confirmation]', with: @password

    click_button 'Create Account'

    visit 'http://localhost:1080'

    allow_any_instance_of(ActionDispatch::Request::Session).
      to receive(:[]).
      and_return(User.last.id)

    emails = page.find_all('tr')
    within emails[1] do
      find('td', text: 'Welcome to Brownfield!').click
    end

    within_frame(:css, '.body') do
      click_link 'Verify Email'
    end

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content(@email)
    expect(page).to have_content(@first_name)
    expect(page).to have_content(@last_name)
    expect(page).to_not have_content('Sign In')
  end

  it 'unverified users cannot login' do
    visit new_user_path

    fill_in 'user[email]', with: @email
    fill_in 'user[first_name]', with: @first_name
    fill_in 'user[last_name]', with: @last_name
    fill_in 'user[password]', with: @password
    fill_in 'user[password_confirmation]', with: @password

    click_button 'Create Account'

    visit login_path

    fill_in 'user[email]', with: @email
    fill_in 'user[password]', with: @password

    click_button 'Log In'

    expect(current_path).to eq(login_path)
    expect(page).to have_content 'You must verify your email to continue'
    expect(page).to have_link 'Send Another'
  end
end
