class ApplicationController < ActionController::Base
  respond_to :json
  before_filter :set_cache_buster

  rescue_from CanCan::AccessDenied do |exception|
    head :unauthorized
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  private

  def mobile_device?
    request.user_agent =~ /Mobile|iP(hone|od|ad)|Android|BlackBerry|IEMobile|Kindle|NetFront|Silk-Accelerated|(hpw|web)OS|Fennec|Minimo|Opera M(obi|ini)|Blazer|Dolfin|Dolphin|Skyfire|Zune/
  end

  helper_method :mobile_device?
  
  def validate_current_user
    head :unauthorized unless current_user
  end
  
  def current_user 
    super || guest_user
  end

  private 
  def guest_user
    #User.find(session[:guest_user_id].nil? ? session[:guest_user_id] = create_guest_user.id : session[:guest_user_id])
    if session[:guest_user_id].nil?
      return nil
    else
      return User.find_by_id(session[:guest_user_id])
    end
  end
  
  def create_guest_user
    user = User.new(:first_name=>"guest", :email=>"guest_#{Time.new.to_i}#{rand(99)}@guest.com")
    user.is_guest = true
    user.save(:validate=>false)
		user
  end


end
