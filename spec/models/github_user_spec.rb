require 'rails_helper'

RSpec.describe GithubUser do

    it "exists" do 
        follower_info = {

            html_url: "https://bobs_your_uncle",
            login: "Uncle Bob",
            test_attr: "coffee",
            test_attr2: "cream",
            test_attr3: 12
        }

        follower = GithubUser.new(follower_info)

        expect(follower).to be_a GithubUser
        expect(follower.name).to eq("Uncle Bob")
        expect(follower.url).to eq("https://bobs_your_uncle")
    end
end