require 'rails_helper'

RSpec.describe Repo, type: :model do
  describe 'initializing' do
    data = {name: 'Becky', html_url: 'heroku.com'}
    repo = Repo.new(data)
    it "should be able to find initialized details" do
      expect(repo.name).to eq('Becky')
      expect(repo.url).to eq('heroku.com')
    end
  end
end
