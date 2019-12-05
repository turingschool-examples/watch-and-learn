require 'rails_helper'

describe GithubService do
  it "returns github data", :vcr do
    search = subject.repos_by_user
    expect(search).to be_an Array
  end
end
