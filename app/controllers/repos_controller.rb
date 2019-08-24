class ReposController < ApplicationController

def create

      oauth_response = Faraday.get("https://api.github.com/user?access_token=7dd508700f00e6160a724fb99c8e854df98a0e0a")

      @auth = JSON.parse(oauth_response.body)

      

      redirect_to dashboard_path
end

end
