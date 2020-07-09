require "rails_helper"

RSpec.describe InvitationNotifierMailer, type: :mailer do
  describe "instruction" do
    it 'renders the subject and field' do

      json_self_info = File.read("spec/fixtures/github_self_info.json")
      stub_request(:get, "https://api.github.com/users/EricLarson2020").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'token 127a71214eb55ed59a8fb9c7b8a1ea75bcd11f19',
          'User-Agent'=>'Faraday v1.0.1'
           }).
         to_return(status: 200, body: json_self_info, headers: {})
         json_self_info = File.read("spec/fixtures/github_self_info.json")
         stub_request(:get, "https://api.github.com/user").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'token 127a71214eb55ed59a8fb9c7b8a1ea75bcd11f19',
          'User-Agent'=>'Faraday v1.0.1'
           }).
         to_return(status: 200, body: json_self_info, headers: {})


      user_1 = User.create(
        email: "user_1@email.com",
        first_name: "Eric",
        last_name: "bobby",
        password: "password",
        role: 0,
        token: ENV['GITHUB_TOKEN']
      )

      github_handle = "EricLarson2020"

      InvitationNotifierMailer.invite(user_1, github_handle).deliver_now

      activation_email = ActionMailer::Base.deliveries.last

      expect(activation_email.subject).to eq("Brownfield-of-Dreams: Invitation")
      expect(activation_email.to.first).to eq("ericlarsonbroom@gmail.com")
    end
  end
end
