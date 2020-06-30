require 'rails_helper'

describe Repo do
  it "exists" do
    repo_data = {
      name: 'futbol',
      html_url: 'futbol.com'
    }

    repo = Repo.new(repo_data)

    expect(repo).to be_a Repo
    expect(repo.name).to eq('futbol')
    expect(repo.html_url).to eq('futbol.com')
  end
end
