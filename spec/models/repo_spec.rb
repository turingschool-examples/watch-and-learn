require "rails_helper"

describe Repo do
  it "exists" do
    attrs = {
      name: "brownest-fields",
      html_url: "http://github.com/froydroyce/brownest-fields",
    }

    repo = Repo.new(attrs)

    expect(repo).to be_a Repo
    expect(repo.name).to eq("brownest-fields")
    expect(repo.html_url).to eq("http://github.com/froydroyce/brownest-fields")
  end
end
