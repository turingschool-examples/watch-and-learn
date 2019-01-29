require 'rails_helper'

describe Repo, type: :model do
  it "exists" do
    repo = Repo.new({})
    expect(repo).to be_a(Repo)
  end

  it "has attributes" do
    attributes = {
      id: 160538403,
      name: "activerecord-obstacle-course",
      full_name: "stoic-plus/activerecord-obstacle-course",
      owner: {},
      html_url: "https://github.com/stoic-plus/activerecord-obstacle-course",
      description: "Backend Module 2, Active Record practice exercises"
    }

    repo = Repo.new(attributes)

    expect(repo.id).to eq(attributes[:id])
    expect(repo.name).to eq(attributes[:name])
    expect(repo.full_name).to eq(attributes[:full_name])
    expect(repo.owner).to eq(attributes[:owner])
    expect(repo.html_url).to eq(attributes[:html_url])
    expect(repo.description).to eq(attributes[:description])
  end
end
