module Api
  module Authentication
    extend ActiveSupport::Concern

    included do
      before_action :authenticate
    end

    protected

    attr_reader :current_user

    def authenticate
      authenticate_with_http_basic(&method(:authenticate_user))
      raise Api::Errors::Unauthorized unless current_user
    end

    def authenticate_user(user, password)
      @current_user = User.find_by(username: user).try(:authenticate, password)
    end
  end
end
