require 'rails_helper'

RSpec.describe GithubUser, type: :model do
	before :each do 
		@test_user = GithubUser.new(login: "Jimbob", html_url: "www.googleit.com")
	end

	it 'exists' do
		expect(@test_user).to be_a(GithubUser)
	end

	it 'has attributes' do
		expect(@test_user.login).to eq("Jimbob")
		expect(@test_user.html_url).to eq("www.googleit.com")
	end
end
