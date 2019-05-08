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

    it "gets followers" do
      service = GithubService.new

      result = service.get_followers

      expect(result).to be_an(Array)
      expect(result.first).to have_key(:login)
      expect(result.first).to have_key(:html_url)
    end

    it "gets following" do
      service = GithubService.new

      result = service.get_following

      expect(result).to be_an(Array)
      expect(result.first).to have_key(:login)
      expect(result.first).to have_key(:html_url)
    end

  end
end
