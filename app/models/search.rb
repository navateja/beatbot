class Search < ActiveRecord::Base

 	def self.get_video_url(search_term)
		search_term.gsub!(' ','+')
		search_term.gsub!('\'','%27')
		base_url = "https://gdata.youtube.com/feeds/api/videos?v=2&alt=jsonc&q="
		url = base_url + search_term + "&start-index=1&max-results=10"
		return url
	end

	def self.get_search_results(url_to_search)
		curl = Curl::Easy.new(url_to_search)
		curl.perform
		res_str = curl.body_str

		final_arr = []

		r = JSON.parse(res_str, :quirks_mode => true)
		r['data']['items'].each do |x|
			final_arr << {:id => x['id'], :name => x['title'], :url => "http://www.youtube.com/watch?v="+x['id']} 
		end
		final_arr
	end

	def self.get_suggestions(query)
		url_to_search = self.get_video_url(query)
		self.get_search_results(url_to_search)
 	end 
end
