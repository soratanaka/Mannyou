class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?

  private

  def production?   #←本番環境かローカルを区別する。
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

end