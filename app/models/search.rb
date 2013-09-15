class Search < ActiveRecord::Base
	
	def self.get_suggestions(query)
  	[{:name => "abc", :title => "abc", :id => "123"}, {:name => "adf", :title => "adf", :id => "456"}]
 	end 
end
