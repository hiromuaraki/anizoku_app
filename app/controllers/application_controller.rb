include SessionsHelper

class ApplicationController < ActionController::Base
  def validate_admin?
    current_user.admin? 
  end
end