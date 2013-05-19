class ApplicationController < ActionController::Base
  protect_from_forgery
  # TODO: Filter this for dev ENV only
  before_filter :set_cache_buster

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
	def after_sign_in_path_for(resource)
		render :json=>{:id=>resource.id, :first_name=>resource.first_name, :last_name=>resource.last_name}
	end
end
