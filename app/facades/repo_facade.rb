# frozen_string_literal: true

class RepoFacade
  def create_repos(current_user)
    get_repo_data(current_user).map do |repo|
      Repo.new(repo)
    end[0..4]
  end

  def get_repo_data(current_user)
    GithubSearchResults.new(current_user).repos

  end
end
