module YouTube
  class Playlist
    attr_reader :items

    def initialize(id)
      @service = YoutubeService.new
      @items = if @service.get_playlist_token(id).nil?
                 @service.playlist_info(id)[:items]
               else
                 get_combined_playlist(id)
               end
    end

    def get_combined_playlist(id)
      combined_list = @service.playlist_info(id)[:items]
      token = @service.get_playlist_token(id)
      until token.nil?
        @service.playlist_info(id, token)[:items].each do |item|
          combined_list << item
        end
        token = @service.get_playlist_token(id, token)
      end
      combined_list
    end
  end
end
