class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  serialization_scope :view_context

  def require_admin
    unless current_user and current_user.is_admin?
      flash[:notice] = 'This is only for admin users.'
      redirect_to :root
    end
  end
end
