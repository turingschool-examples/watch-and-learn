require 'rails_helper'

describe GithubService do
  context "#repo-info" do
    it "returns data good" do
      data = subject.repos
      expect(something).to eq(something_else)
    end
  end
end
