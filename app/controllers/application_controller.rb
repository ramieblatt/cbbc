class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  serialization_scope :view_context

  layout :layout_by_subdomain

  def require_admin
    unless current_user and current_user.is_admin?
      flash[:notice] = 'This is only for admin users.'
      redirect_to :root
    end
  end

  def is_admin_request?
    request.subdomain == 'admin'
  end

  def is_api_request?
    request.subdomain == 'api'
  end

  private

  def layout_by_subdomain
    if request.subdomain == 'admin'
      "application"
    else
      "www"
    end
  end

end
