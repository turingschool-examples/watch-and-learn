require 'rails_helper'

describe 'A registered user' do
  it "can see a github section with 5 repos" do
    user = create(:user, token: ENV["GITHUB_TOKEN"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(dashboard_path)

    expect(page).to have_css('.github')
  end

  it "can't see a github section if user has no token" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(dashboard_path)

    expect(page).to_not have_css('.github')
  end

  xit "can see a github section with only thier repos" do
    user_1 = create(:user, token: ENV["GITHUB_TOKEN"])
    user_2 = create(:user, token: ENV["GITHUB_TOKEN_2"])
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit(dashboard_path)

    within('.github') do
      expect()
    end
  end


end
