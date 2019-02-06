require 'rails_helper'

describe 'on the GithubService' do
  it "it exists" do
    token = 'adsfadsgkasl'
    ghs = GithubService.new(token)

    expect(ghs).to be_a(GithubService)
  end

  describe 'instance methods' do
    it '.repos' do
      VCR.use_cassette("services/find_repositories") do
        token = ENV["GITHUB_API_KEY"]
        repos = GithubService.new(token).repos

        expect(repos).to be_a(Array)
        expect(repos.first).to have_key(:name)
        expect(repos.first).to have_key(:html_url)
      end
    end
    it '.followers' do
      VCR.use_cassette("services/find_followers") do
        token = ENV["GITHUB_API_KEY"]
        followers = GithubService.new(token).followers

        expect(followers).to be_a(Array)
        expect(followers.first).to have_key(:login)
        expect(followers.first).to have_key(:html_url)
      end
    end

    it '.followings' do
      VCR.use_cassette("services/find_followings") do
        token = ENV["GITHUB_API_KEY"]
        followings = GithubService.new(token).followings

        expect(followings).to be_a(Array)
        expect(followings.first).to have_key(:login)
        expect(followings.first).to have_key(:html_url)
      end
    end

    describe '.invitee' do
      scenario "has email" do
        token = ENV["GITHUB_API_KEY"]
        handle = 'stoic-plus'
        VCR.use_cassette('services/find_invitee') do
          invitee = GithubService.new(token).invitee(handle)
          expect(invitee).to have_key(:name)
          expect(invitee).to have_key(:email)
        end
      end
      scenario "has no email" do
        token = ENV["GITHUB_API_KEY"]
        handle = 'Bradniedt'
        VCR.use_cassette('services/find_invitee_no_email') do
          invitee = GithubService.new(token).invitee(handle)
          expect(invitee[:email]).to eq(nil)
        end
      end
    end

    it '.inviter' do
      token = ENV["GITHUB_API_KEY"]
      VCR.use_cassette('services/find_inviter') do
        inviter = GithubService.new(token).inviter
        expect(inviter).to have_key(:name)
      end
    end
  end
end
