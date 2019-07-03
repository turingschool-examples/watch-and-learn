require "rails_helper"

describe UserDashboardFacade do
  it "exists" do
    test_facade = UserDashboardFacade.new(ENV["GITHUB_API_KEY"])
    #TODO update with Oauth token
    expect(test_facade).to be_a(UserDashboardFacade)
  end

  it "#repos" do
    test_facade = UserDashboardFacade.new(ENV["GITHUB_API_KEY"])
    expect(test_facade.repos(2)).to be_a(Array)
    expect(test_facade.repos(2).first).to be_a(Repository)
    expect(test_facade.repos(2).first.name).to eq("book_club")
  end
end
