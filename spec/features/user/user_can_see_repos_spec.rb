require 'rails_helper'

describe 'User Dashboard' do
  it 'displays Github repos' do

    json_response = File.open('./spec/fixtures/github_repo_view_data.json')

    stub_request(:get, "https://api.github.com/user/repos")
    .to_return(status: 200, body: json_response)

    user = create(:user, github_token: ENV["GITHUB_API_KEY"])

    visit '/'

    click_on 'Sign In'

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(page).to have_css(".github-repositories")

    within ".github-repositories" do
      expect(page).to have_link("...")
      expect(page).to have_link("a")
      expect(page).to have_link("repo_1")
      expect(page).to have_link("repo_2")
      expect(page).to have_link("repo_3")
    end

    # click_link("repo_1")
    # expect(current_path).to eq("https://github.com/alect47/a")
  end
end
