require 'rails_helper'

describe GithubService, type: :service do
  context "instance methods", :vcr do
    it "gets repos" do
      service = GithubService.new

      result = service.get_repos

      expect(result).to be_an(Array)
      expect(result.first).to have_key(:name)
      expect(result.first).to have_key(:html_url)
    end
  end
end
