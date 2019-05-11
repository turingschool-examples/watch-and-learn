require 'rails_helper'

RSpec.describe GithubService, type: :model do
  describe 'instance methods' do
    describe 'repos', :vcr do
      it 'collects repos from the api' do
        service = GithubService.new(token: "8e08129aa359391e0f54b1192be5a9c3bb819e09")

        result = service.get_repos

        expect(result).to be_a(Array)
        expect(result.count).to eq(5)
        expect(result[0]).to be_a(Hash)
      end
    end
  end
end
