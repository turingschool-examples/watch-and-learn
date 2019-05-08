require 'rails_helper'

describe Repo, type: :model do

  it "exists" do
    attributes = {
      name: "My favorite Repo",
      html_url: "localhost:3000"
    }
    repo = Repo.new(attributes)
    expect(repo).to be_a(Repo)
  end

  it "has attributes" do
    attributes = {
      name: "My favorite Repo",
      html_url: "localhost:3000"
    }
    repo = Repo.new(attributes)
    expect(repo.name).to eq("My favorite Repo")
    expect(repo.html_url).to eq("localhost:3000")
  end
end
