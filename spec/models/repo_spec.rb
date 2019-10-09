require 'rails_helper'

describe 'Repo' do
  before :each do
    @repo = Repo.new({name: 'Bob', html_url: 'example.com'})
  end

  it 'can initialize with a hash of name and url' do
    expect(@repo).to be_an_instance_of(Repo)
  end

  it 'has attributes name, url' do
    expect(@repo.name).to eq('Bob')
    expect(@repo.html_url).to eq('example.com')
  end
end
