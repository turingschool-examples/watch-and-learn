require 'rails_helper'

describe GithubApi do

  it "exists" do
    api_call = GithubApi.new
    api_call.repos
  expect(page).to have_content("")
end
  end
