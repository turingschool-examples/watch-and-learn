class SearchResults

    def repos(token)   
        @repos = GithubService.new.repos(token)
    end
end