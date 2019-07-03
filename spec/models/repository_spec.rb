require "rails_helper"

describe Repository, type: :model do
  it "exists" do
    test_repository = Repository.new({name: "test", html_url: "test_2"})
    expect(test_repository).to be_a(Repository)
  end
  it "has attributes" do
    test_repository = Repository.new({name: "test", html_url: "test_2"})
    expect(test_repository.name).to eq("test")
    expect(test_repository.html_url).to eq("test_2")
  end
end
