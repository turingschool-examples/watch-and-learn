require 'rails_helper'

RSpec.describe Follower, type: :model do
  describe 'initializing' do
    data = {login: 'rer7891', html_url: 'heroku.com', u_id: '1234'}
    follower = Follower.new(data)
    it "should be able to find initialized details" do
      expect(follower.name).to eq('rer7891')
      expect(follower.url).to eq('heroku.com')
      expect(follower.u_id).to eq('1234')
    end
  end
end
