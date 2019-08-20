require 'rails_helper'

describe 'User dashboard' do
  before :each do
    json_response = File.open("./fixtures/repositories.json")
    stub_request(:get, "https://api.github.com/user/repos").
      to_return(status: 200, body: json_response)

    user = create(:user)
    visit '/'
    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)
  end

  it 'user can visit the dashboard' do
    expect(page).to have_content("GitHub")

    expect(page).to have_css(".repository", count: 5)

    within(first(".repository")) do
      expect(page).to have_css(".name")
    end
  end
end
