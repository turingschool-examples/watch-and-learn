require 'rails_helper'

RSpec.describe YouTube::Video, type: :model do
  it "has a thumbnail when created" do
    data = { :items=>
              [{:kind=>"youtube#video",
                :etag=>"\"j6xRRd8dTPVVptg711_CSPADRfg/RBZfdvpRWjO90L2QxoMLaoB5HcY\"",
                :id=>"J7ikFUlkP_k",
                :snippet=>
                 {:publishedAt=>"2018-07-23T20:59:59.000Z",
                  :channelId=>"UC2zYYOtckevoWTGDu5SdCkg",
                  :title=>"Rails Integration Tests for Pages with JavaScript",
                  :description=>
                   "This video shows how to write feature/integration tests within RSpec configured to run expectations for pages that run JavaScript.",
                  :thumbnails=>
                   {:default=>
                     {:url=>"https://i.ytimg.com/vi/J7ikFUlkP_k/default.jpg",
                      :width=>120,
                      :height=>90},
                    :medium=>
                     {:url=>"https://i.ytimg.com/vi/J7ikFUlkP_k/mqdefault.jpg",
                      :width=>320,
                      :height=>180},
                    :high=>
                     {:url=>"https://i.ytimg.com/vi/J7ikFUlkP_k/hqdefault.jpg",
                      :width=>480,
                      :height=>360}}}}]}

    video = YouTube::Video.new(data)
    expect(video.thumbnail).to eq("https://i.ytimg.com/vi/J7ikFUlkP_k/hqdefault.jpg")
  end

  it "can find itself by id", :vcr do
    data = { :items=>
              [{:kind=>"youtube#video",
                :etag=>"\"j6xRRd8dTPVVptg711_CSPADRfg/RBZfdvpRWjO90L2QxoMLaoB5HcY\"",
                :id=>"J7ikFUlkP_k",
                :snippet=>
                 {:publishedAt=>"2018-07-23T20:59:59.000Z",
                  :channelId=>"UC2zYYOtckevoWTGDu5SdCkg",
                  :title=>"Rails Integration Tests for Pages with JavaScript",
                  :description=>
                   "This video shows how to write feature/integration tests within RSpec configured to run expectations for pages that run JavaScript.",
                  :thumbnails=>
                   {:default=>
                     {:url=>"https://i.ytimg.com/vi/J7ikFUlkP_k/default.jpg",
                      :width=>120,
                      :height=>90},
                    :medium=>
                     {:url=>"https://i.ytimg.com/vi/J7ikFUlkP_k/mqdefault.jpg",
                      :width=>320,
                      :height=>180},
                    :high=>
                     {:url=>"https://i.ytimg.com/vi/J7ikFUlkP_k/hqdefault.jpg",
                      :width=>480,
                      :height=>360}}}}]}

    video = YouTube::Video.by_id('iXLwXvev4X8')

    expect(video).to be_a(YouTube::Video)
  end
end