require "rails_helper"

RSpec.describe 'User' do
  it 'Can see github with 5 repositories' do
    user = create(:user, token: ENV["GITHUB_TOKEN"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(dashboard_path)
    expect(page).to have_css('.github')

  end
end
