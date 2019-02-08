require "rails_helper"

RSpec.describe ModelMailer, type: :mailer do
  describe "new_record_notification" do
    let(:mail) { ModelMailer.new_record_notification(create(:user)) }

    it "renders the headers" do
      expect(mail.subject).to eq("Welcome #{User.last.first_name}")
      expect(mail.to).to eq([User.last.email])
      expect(mail.from).to eq(["postman@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to have_content("Thanks for signing up!")
      expect(mail.body.encoded).to have_content(activation_url(User.last, host: 'https://hidden-springs-90979.herokuapp.com'))
    end
  end

end
