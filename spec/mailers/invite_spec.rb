require "rails_helper"

RSpec.describe InviteMailer, :type => :mailer do
  describe "invite" do
    before :each do
      @user = create(:user)
      @github_user = create(:github_token, user: @user, token: ENV['USER_1_GITHUB_TOKEN'])

      attributes = {
        login: "jamisonordway",
        html_url: "https://github.com/jamisonordway",
        email: "jamison@email.com",
        id: "12345"
      }

      @github_user = GithubUser.new(attributes)

      @body = "has invited you to join Brownfield of Dreams. You can create an account"

      @mail = InviteMailer.invite(@user, @github_user )
    end

    it "renders the headers" do
      expect(@mail.subject).to eq("#{@user.first_name} wants to invite you to Brownfield of Dreams.")
      expect(@mail.to).to eq([@github_user.email])
    end

    it "renders the body" do
      expect(@mail.body.encoded).to include(@body)
    end
  end
end
