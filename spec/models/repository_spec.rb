require "rails_helper"

describe Repository do
  it "exists" do
    attributes = {}
    repository = Repository.new(attributes)

    expect(repository).to be_a(Repository)
  end

  it 'has attributes' do
    attributes = {
                  name: "bob",
                  html_url: "github.com"
    }
    repository = Repository.new(attributes)

    expect(repository.name).to eq("bob")
    expect(repository.html_url).to eq("github.com")
  end
end
