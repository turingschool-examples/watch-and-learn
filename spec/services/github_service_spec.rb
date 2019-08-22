require 'rails_helper'

describe GithubService do
  context "instance methods" do
    context "#github_repos" do
      it "returns github data" do
        stub_dashboard_api_calls
        repos = subject.repos

        expect(repos).to be_a Array
        expect(repos[0]).to be_a Hash
        expect(repos.count).to eq(30)
        expect(repos[0]).to have_key :name
      end
    end
  end
end


# And now we need to define PropublicaService. Let’s write a test for that.
#
# # /spec/services/propublica_service_spec.rb
#
# require 'rails_helper'
#
# describe PropublicaService do
#   context "instance methods" do
#     context "#members_by_state" do
#       it "returns member data" do
#         search = subject.members_by_state("CO")
#         expect(search).to be_a Hash
#         expect(search[:results]).to be_an Array
#         expect(search[:results].count).to eq 7
#         member_data = search[:results].first
#
#         expect(member_data).to have_key :name
#         expect(member_data).to have_key :role
#         expect(member_data).to have_key :district
#         expect(member_data).to have_key :party
#       end
#     end
#   end
# end
