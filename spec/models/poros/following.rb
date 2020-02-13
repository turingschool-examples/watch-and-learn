require 'rails_helper'

RSpec.describe Following, type: :model do
  describe 'initializing' do
    data = {login: 'rer7891', html_url: 'heroku.com', u_id: '1234'}
    following = Following.new(data)
    it "should be able to find initialized details" do
      expect(following.name).to eq('rer7891')
      expect(following.url).to eq('heroku.com')
      expect(following.u_id).to eq('1234')
    end
  end
end
