require "rails_helper"

RSpec.describe GithubInviterMailer, type: :mailer do
  include Capybara::Email::DSL
  context '.invite' do
    it 'sends an invitation email with proper format' do
      user = create(:user, first_name: 'Jon', last_name: 'Doe')
      invitee = GithubUser.new({login: "stoic-plus", html_url: "https://api.github.com/users/stoic-plus", email: "smtp://127.0.0.1:1025"})

      GithubInviterMailer.invite(user, invitee).deliver_now
      open_email('smtp://127.0.0.1:1025')
      expect(current_email).to have_content("Hello stoic-plus,")
      expect(current_email).to have_content("Jon, Doe has invited you to join Brownfield of Dreams. You can create an account here")
      expect(current_email).to have_link("here", href: "http://localhost:3000/register")
    end
  end
end
