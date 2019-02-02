require 'rails_helper'


describe 'About and Getting started', :js do
  it 'shows information on about page' do
    visit '/about'

    expect(page).to have_content("Turing Tutorials")
    expect(page).to have_content("This application is designed to pull in youtube information to populate tutorials from Turing School of Software and Design's youtube channel. It's designed for anyone learning how to code, with additional features for current students.")
  end
  it 'shows information on get_started page' do
    visit '/get_started'

    expect(page).to have_content("Get Started")
    expect(page).to have_content("Browse tutorials from the homepage")
    expect(page).to have_link("homepage", href: "/")
    expect(page).to have_link("Sign in", href: '/login')
  end
end
