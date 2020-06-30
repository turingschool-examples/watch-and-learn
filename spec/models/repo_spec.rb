require 'rails_helper'

describe Repo do
  it "exists" do
    repo_data = {
      name: "repo name",
      html_url: "www.repo_name.com"
    }

    repo = Repo.new(repo_data)

    expect(repo).to be_a Repo
    expect(repo.name).to eq("repo name")
    expect(repo.html_url).to eq("www.repo_name.com")
  end
  
end