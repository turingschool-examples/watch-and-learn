require 'rails_helper'

describe Repo do
  it 'exists' do
    repo = Repo.new({full_name: 'repo1', html_url: 'www.repo.com'})
    expect(repo).to be_a(Repo)
    expect(repo.name).to eq('repo1')
    expect(repo.url).to eq('www.repo.com')
  end
end
