class GithubService

    def repos(token)
        auth = Faraday.get("https://api.github.com/user?access_token=#{token}")
        response = JSON.parse(auth.body, symbolize_names: true)
        all_repos = Faraday.get(response[:repos_url])
        repos = JSON.parse(all_repos.body, symbolize_names: true)[0..4].map{|repo| [repo[:html_url], repo[:name]]} 
    end
end