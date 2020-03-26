module Imageable

	extend ActiveSupport::Concern

        def remote_file_image?(url)
		if uri?(url)
			response = Faraday.get(url).env.response_headers["content-type"].include?('image') == true	
		else
			false
		end	
        end

	def uri?(string)
                  uri = URI.parse(string)
                  %w( http https ).include?(uri.scheme)
                rescue URI::BadURIError
                  false
                rescue URI::InvalidURIError
                  false
        end   
end
