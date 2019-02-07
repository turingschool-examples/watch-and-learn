require 'rails_helper'

describe 'Visitor can create an account', :js do
  it ' visits the home page' do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on'Create Account'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content(email)
    expect(page).to have_content(first_name)
    expect(page).to have_content(last_name)
    expect(page).to_not have_content('Sign In')
  end
  it 'gets a notice that the account needs to be activated' do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'

    visit '/'
    click_on 'Register'
    
    expect(current_path).to eq('/register')
    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password
    click_on 'Create Account'
    
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Logged in as #{first_name} #{last_name}")
    expect(page).to have_content('This account has not yet been activated. Please check your email.')
    expect(User.last.activated).to eq(false)
    expect(User.last.activation_token).to_not be_nil
  end
  it 'can click on the link in the activation email to activate their account' do
    user = User.create(email: 'jimbob@aol.com', password: 'password', first_name: 'Jim', last_name: 'Bob')
    
    visit activation_path(user.activation_token)
    
    expect(page).to have_content('Thank you! Your account is now activated.')
    
    visit dashboard_path
    
    expect(page).to have_content('Status: Active')
  end
end
