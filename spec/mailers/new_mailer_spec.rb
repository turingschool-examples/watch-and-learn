require 'rails_helper'

RSpec.describe NewMailer, type: :mailer do
  describe 'new_mail' do
    @mailer = NewMailer.new_mail

    it "renders the headers" do
      expect(mail.subject).to eq("New mail")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.to).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end
end
