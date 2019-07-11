require "rails_helper"

describe "As a registered user" do
  it "I can confirm my email", :vcr do
    user_1 = create(:user)
    token = user_1.confirm_token

    visit "http://localhost:3000/users/#{token}/confirm_email"

    expect(current_path).to eq(welcome_path)
    expect(page).to have_content("Thank you! Your account is now activated.")
  end
end
