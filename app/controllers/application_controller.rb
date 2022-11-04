class ApplicationController < ActionController::Base
  before_action :basic if Rails.env == "production"
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required

  def autheniticate_user
    if @current_user==nil
      flash[:notice]="ログインが必要です"
      redirect_to("/login")
    end
  end
  
  private
  def basic
    authenticate_or_request_with_http_basic do |name, password|
      name == ENV['BASIC_AUTH_NAME'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def login_required
    redirect_to new_session_path unless current_user
  end
end
