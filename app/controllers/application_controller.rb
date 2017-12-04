class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Clearance::Controller
  protect_from_forgery with: :exception
  
  before_action :redirect_to_proper_url

  def redirect_to_proper_url
    if Rails.env.production?
      if ['climbingfaq.com', 'www.climbingfaq.com', 'www.climbfaq.com'].include?(request.host) or !request.ssl?
        redirect_to(ENV['SITE_URL'] + request.fullpath, status: :moved_permanently)
      end
    end
  end
  
  def require_admin
    not_found if !current_user.admin?
  end
  
  def forbidden(reason)
    raise ActionController::BadRequest.new(reason)
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
    
end
