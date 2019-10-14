namespace :videos_db do
  desc "No videos with nil position"

  task :change_position => :environment do
    videos = Video.all
    binding.pry
    videos.map.with_index(1) do |video, index|
      video[:position] = index
    end
    binding.pry
  end
end

# desc :"Create Videos"
# task :videos, [:videos] => :environment do
#   tutorials = Tutorial.all
#   tutorials.each do |tutorial|
#     response = Faraday.get("https://www.googleapis.com/youtube/v3/playlistItems?key=#{ENV['YOUTUBE_API_KEY']}&playlistId=#{tutorial.playlist_id}&part=snippet&maxResults=50&order=date")
#     data = JSON.parse(response.body, symbolize_names: true)
#     data[:items].each.with_index(1) do |vid, index|
#       tutorial.videos.create!(
#         title: vid[:snippet][:title],
#         description: vid[:snippet][:description],
#         thumbnail: vid[:snippet][:thumbnails][:high][:url],
#         video_id: vid[:snippet][:resourceId][:videoId],
#         position: index
#       )
#     end
#   end
# end
