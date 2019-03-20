require 'rails_helper'

describe Follower do
  it 'exists' do
    repo = Follower.new({login: 'repo1', html_url: 'www.repo.com'})
    expect(repo).to be_a(Follower)
    expect(repo.name).to eq('repo1')
    expect(repo.url).to eq('www.repo.com')
  end
end
