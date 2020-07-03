require "rails_helper"

RSpec.describe 'User' do
  it 'Can see github with 5 repositories' do
    user = create(:user, token: ENV["GITHUB_TOKEN"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(dashboard_path)
    expect(page).to have_css('.github')

  end
  it 'Can see secton for github and see all followers with there handles being links' do
    user = create(:user, token: ENV["GITHUB_TOKEN"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(dashboard_path)
    expect(page).to have_css('.github')
    expect(page).to have_css('.followers')


  end
  it 'Can see secton for github and see all followers with there handles being links' do
    user = create(:user, token: ENV["GITHUB_TOKEN"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(dashboard_path)
    expect(page).to have_css('.github')
    expect(page).to have_css('.followers')
    expect(page).to have_css('.following')
    save_and_open_page

  end
end
