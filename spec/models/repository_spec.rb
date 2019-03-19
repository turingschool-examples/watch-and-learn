require 'rails_helper'

describe Repository do

  it 'exists' do
    repository = Repository.new({})

    expect(repository).to be_a(Repository)
  end

  it 'has attributes' do
    repo = Repository.new({name: 'name', html_url: 'url'})

    expect(repo.name).to eq('name')
    expect(repo.url).to eq('url')
  end
end
