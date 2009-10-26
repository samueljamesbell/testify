class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user, :logged_in?, :site_name
  
  rescue_from ActionController::UnknownAction, :with => :unknown
  rescue_from ActionController::RoutingError, :with => :unknown
  rescue_from ActiveRecord::RecordNotFound, :with => :unknown
  
  def unknown
  	render :template => "public/404.html", :status => 404
  end
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '8ffb6e2a5aa08dbb632fbaab1a328b68'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  def site_name
    "Testify"
  end
  
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
  
  def admin?
  	logged_in? && current_user.email == 'samueljamesbell@googlemail.com'
  end
  
  def ensure_admin
		unless admin?
  		redirect_to welcome_path
  	end
  end

  def logged_in?
    !current_user.nil?
  end
  
protected

  def log_action(object_type, object_id, action_type)
  	Action.create!(:object_type => object_type, :object_id => object_id, :action_type => action_type, :user_id => current_user.id)
  end
  
  def authorise
 		return if logged_in?
  	session[:original_uri] = request.request_uri
  	flash[:notice] = "Please log in"
    redirect_to login_path
  end

end
