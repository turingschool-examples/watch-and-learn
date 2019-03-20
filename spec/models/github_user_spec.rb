require 'rails_helper'

describe GithubUser do
  before :each do
    VCR.use_cassette("github service followers") do
      @github_data = GithubService.new.get_followers[0]
      @follower = GithubUser.new(@github_data)
    end
  end

  it 'exists' do
    expect(@follower).to be_a(GithubUser)
  end

  it 'has a handle' do
    expect(@follower.handle).to eq(@github_data[:login])
  end
end
