require 'rails_helper'

#webmock enable for doing real http request

RSpec.describe "github api service" do
  it "returns repos", :vcr do
    #VCR.use_cassette("propublica_member_data") do
    service = GithubSearchResults.new
    array_of_hashes_data = service.repos

    # binding.pry

    expect(service).to be_an_instance_of(GithubSearchResults)

    expect(array_of_hashes_data).to be_a(Array)
    expect(array_of_hashes_data.first).to have_key(:name)
    expect(array_of_hashes_data.first).to have_key(:url)
    expect(array_of_hashes_data.count).to eq(30)
    #end
  end
end
