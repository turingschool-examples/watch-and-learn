require 'rails_helper'

describe Following do
  it 'exists' do
    repo = Following.new({login: 'repo1', html_url: 'www.repo.com'})
    expect(repo).to be_a(Following)
    expect(repo.name).to eq('repo1')
    expect(repo.url).to eq('www.repo.com')
  end
end
