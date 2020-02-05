require 'rails_helper'

RSpec.describe Repo do
  it "instantiates with name and url" do
    repo = Repo.new(name: 'repo name', url: 'test_url.com')
    expect(repo).to be_instance_of(Repo)
    expect(repo.name).to eq('repo name')
    expect(repo.url).to eq('test_url.com')
  end
end
