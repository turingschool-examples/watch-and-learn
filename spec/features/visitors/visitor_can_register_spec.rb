require 'rails_helper'

describe 'As a visitor', :js do
  it 'I can register with acceptable credentials' do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(register_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on 'Create Account'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Logged in as #{first_name} #{last_name}.")

    within(".dashboard-acct-details") do
      expect(page).to have_content(email)
      expect(page).to have_content(first_name)
      expect(page).to have_content(last_name)
    end

    expect(page).to_not have_content('Sign In')
  end

  it "I can't register with dupicate username" do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    create(:user, email: email)

    visit '/register'

    expect(current_path).to eq(register_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password_confirmation

    click_on 'Create Account'

    expect(page).to have_content('Email already exists')
    expect(page).to have_content('Register')
  end

describe 'after registering with acceptable credentials'
  it 'my status is inactive and I receive an activation email' do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit register_path

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on 'Create Account'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Status: This account has not yet been activated. Please check your email.")

    email = ActionMailer::Base.deliveries.last
    email_body = email.parts.first.body.raw_source

    expect(email.subject).to eq("You're almost there!")
    expect(email_body).to have_content("Welcome! Your registration has been initiated. Please visit here to activate your account.")
    expect(email_body).to have_link("here", href: "http://localhost:3000/activate/#{User.last.id}")
  end

  it 'I can activate my account through the link in my email' do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'

    visit register_path

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on 'Create Account'

    user = User.last

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Status: This account has not yet been activated. Please check your email.")

    visit activate_path(user)

    expect(page).to have_content("Thank you! Your account is now activated.")

    expect(User.last.status).to eq("active")
  end

  it "I can't activate my account unless I'm logged in" do
    user = create(:user)

    expect(user.status).to eq("inactive")

    visit activate_path(user)

    expect(current_path).to eq(login_path)

    expect(page).to have_content("You must be logged in to activate your account. Please login and try again.")

    expect(user.status).to eq("inactive")
  end

  it "I can't activate other accounts" do
    user = create(:user)
    other_user = create(:user)

    expect(user.status).to eq("inactive")
    expect(other_user.status).to eq("inactive")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit activate_path(other_user)

    expect(page).to have_content("The page you're looking for could not be found.")

    expect(user.status).to eq("inactive")
    expect(other_user.status).to eq("inactive")

    visit activate_path(user)

    expect(page).to have_content("Thank you! Your account is now activated.")

    expect(user.status).to eq("active")
    expect(other_user.status).to eq("inactive")
  end
end
