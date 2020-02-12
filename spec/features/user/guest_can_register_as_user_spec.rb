require 'rails_helper'

describe "As a guest user, when I visit '/'" do
    it 'guest can register by filling in requirements and submitting' do
        visit '/'
        click_on "Register"

        fill_in "Email", with: "register@example.com"
        fill_in "First name", with: "reg"
        fill_in "Last name", with: "ister"
        fill_in "Password", with: "secret"
        fill_in "Password confirmation", with: "secret"

        click_on "Create Account"

        user = User.last
        expect(current_path).to eq("/dashboard")
        expect(page).to have_content("Logged in as #{user.first_name}")
        expect(page).to have_content("This account has not yet been activated. Please check your email")
    end 
end 