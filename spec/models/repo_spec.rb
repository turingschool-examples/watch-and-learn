
require "rails_helper"

describe Repo do
  it "exists" do
    attrs = {
      name: "brownfield-of-dreams",
      full_name: "/foleymichelle9/brownfield-of-dreams",
    }

    repo = Repo.new(attrs)

    expect(repo).to be_a Repo
    expect(repo.name).to eq("brownfield-of-dreams")
    expect(repo.full_name).to eq("/foleymichelle9/brownfield-of-dreams")
    # expect(repo.html_url).to eq("https://github.com/foleymichelle9/brownfield-of-dreams")
  end
end