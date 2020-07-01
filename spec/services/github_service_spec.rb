require 'rails_helper'

describe 'Github Service' do
  # let :user do
  #   create(:user)
  # end
  describe '#fetch_repos_for_user' do
    it 'returns a list of user repositories' do
      expected = [{:name=>"futbol", :url=>"https://api.github.com/repos/dborski/futbol"},
                  {:name=>"monster_shop_2003",
                  :url=>"https://api.github.com/repos/EricLarson2020/monster_shop_2003"},
                  {:name=>"brownfield-of-dreams",
                  :url=>"https://api.github.com/repos/Gallup93/brownfield-of-dreams"},
                  {:name=>"adopt_dont_shop_paired",
                  :url=>"https://api.github.com/repos/janegreene/adopt_dont_shop_paired"},
                  {:name=>"battleship",
                  :url=>"https://api.github.com/repos/javier-aguilar/battleship"}]

      expect(GithubService.new.fetch_repos_for_user).to eq(expected)
    end
  end 
end