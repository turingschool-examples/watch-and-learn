require 'rails_helper'

describe DashboardFacade do
  it 'exists' do
    attributes = {}
    repo_f = DashboardFacade.new(attributes)

    expect(repo_f).to be_a(DashboardFacade)
  end

  describe 'instance methods' do
    it '#repositories' do
      attributes = {quantity: 5}

      json_response = File.open('./fixtures/repositories.json')
      stub_request(:get, "https://api.github.com/user/repos").
        to_return(status: 200, body: json_response)
      repo_f = DashboardFacade.new(attributes)

      expect(repo_f.repositories.count).to eq(5)
    end
  end
end
