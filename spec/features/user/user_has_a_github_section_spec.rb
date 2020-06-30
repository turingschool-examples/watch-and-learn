require 'rails_helper'

describe 'A registered user' do
  it "can see a github section with 5 repos" do
    user = create(:user, token: ENV["GITHUB_TOKEN"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(dashboard_path)
    save_and_open_page
    expect(page).to have_css('.github')
  end
end
