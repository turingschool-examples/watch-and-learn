require 'rails_helper'

describe Follower do
  before :each do
    VCR.use_cassette("github service followers") do
      @github_data = GithubService.new.get_followers[0]
      @follower = Follower.new(@github_data)
    end
  end

  it 'exists' do
    expect(@follower).to be_a(Follower)
  end

  it 'has a handle' do
    expect(@follower.handle).to eq(@github_data[:login])
  end
end
