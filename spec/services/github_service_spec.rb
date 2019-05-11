require 'rails_helper'

RSpec.describe GithubService, type: :model do
  describe 'instance methods' do
    describe 'repos', :vcr do
      it 'collects repos from the api' do
        service = GithubService.new(token: ENV['GITHUB_TOKEN_KEY'])

        result = service.get_repos

        expect(result).to be_a(Array)
        expect(result.count).to eq(5)
        expect(result[0]).to be_a(Hash)
      end
    end
  end
end
