require 'rails_helper'

describe 'as a user' do
  before(:each) do
    @user = create(:user)
  end

  before(:all) do
    VCR.turn_off!
  end

  after(:all) do
    VCR.turn_on!
  end
  it 'should show me a link to send an invite on my dashboard' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit dashboard_path

    click_button('Send an Invite')

    expect(current_path).to eq(invite_path)
  end

  it 'should show me the flash message when it could send the invite' do
    stub_request(:get, "https://api.github.com/users/plapicola").
    with(
      headers: {
  	  'Accept'=>'*/*',
  	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
  	  'User-Agent'=>'Faraday v0.15.4'
      }).
    to_return(status: 200, body: "{\"name\":\"Sterling Archer\",\"email\":\"bob@bugers.com\"}", headers: {})

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit invite_path

    fill_in "Github handle", with: "plapicola"
    click_button('Send Invite')

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Successfully sent invite!')
  end

  it 'should show me flash message when it could not send the invite' do
    stub_request(:get, "https://api.github.com/users/tymazey").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Faraday v0.15.4'
      }).
    to_return(status: 200, body: "{\"name\":\"Sterling Archer\",\"email\":null}", headers: {})

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit invite_path

    fill_in "Github handle", with: "tymazey"
    click_button('Send Invite')

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end
end
