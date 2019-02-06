require 'rails_helper'

describe Repo do
  it "exists" do
    attributes = {}
    repository = Repo.new(attributes)

    expect(repository).to be_a(Repo)
  end
  it "has attributes" do
    attributes = { name: "Leah",
                   html_url: "https://github.com/le3ah"
                 }
    repository = Repo.new(attributes)
    expect(repository.name).to eq("Leah")
    expect(repository.html_url).to eq("https://github.com/le3ah")
  end
end
