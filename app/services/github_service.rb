class GithubService

    def initialize(token)
        @token = token
    end

    def repos
        all_repos = conn.get("user/repos")
        repos = JSON.parse(all_repos.body, symbolize_names: true)[0..4].map{|repo| [repo[:html_url], repo[:name]]} 
    end

    def followers
        auth = conn.get("user/followers")
        response = JSON.parse(auth.body, symbolize_names: true).map{|follower_info| GithubUser.new(follower_info)}     
    end

    def following
        auth = conn.get("user/following")
        response = JSON.parse(auth.body, symbolize_names: true).map{|follower_info| GithubUser.new(follower_info)}     
    end

    def conn
        Faraday.new("https://api.github.com") do |f|
            f.headers["Authorization"] = "token #{@token}"
        end
    end

end