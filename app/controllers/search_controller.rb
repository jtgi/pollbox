class SearchController < ApplicationController
	include SearchHelper

  	def index
  		@search = Sunspot.search [Room, Question] do 
  			keywords params[:search]
  			paginate(:per_page=>20)
		end
		@results = @search.results
	end
end
