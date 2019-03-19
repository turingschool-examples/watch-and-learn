require 'rails_helper'

describe Repository do

  before :each do
    VCR.use_cassette('github service') do
      @github_data = GithubService.new.get_repos[0]
      @repo = Repository.new(@github_data)
    end
  end
  it 'exists' do
    expect(@repo).to be_a(Repository)
  end

  it 'has a name' do
    expect(@repo.name).to eq(@github_data[:name])
  end

  it 'has a full name' do
    expect(@repo.full_name).to eq(@github_data[:full_name])
  end
end
