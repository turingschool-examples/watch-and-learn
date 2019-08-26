# require 'rails_helper'
#
# describe 'As a logged in user' do
#   describe 'When I visit /dashboard' do
#     describe 'Then I should see a section for Github' do
#       it 'should see a links to all the profiles user is following' do
#         user = create(:user)
#
#         allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
#         allow_any_instance_of(ApplicationController).to receive(:github_token).and_return(ENV['GITHUB_TOKEN'])
#
#         json_response = File.open("./fixtures/github_following.json")
#         stub_request(:get, "https://api.github.com/user/following?access_token=#{ENV['GITHUB_TOKEN']}").
#           to_return(status: 200, body: json_response)
#
#         visit dashboard_path
#
#         within ".github" do
#           expect(page).to have_css(".following")
#
#           within ".following" do
#             expect(page).to have_link('froydroyce')
#           end
#         end
#       end
#     end
#   end
# end
