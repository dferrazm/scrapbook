module Requests
  module HTTPHelpers
    def http_auth(user = nil)
      @current_user = user || create(:user)
      @env ||= {}
      @env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(
        @current_user.username,
        @current_user.password
      )
    end
  end

  module JsonHelpers
    %w(get post put delete).each do |method|
      define_method("json_#{method}") do |*args|
        if args.last.is_a?(Hash)
          args << @env
        else
          args << nil << @env
        end
        send(method, *args)
        JSON.parse(response.body) unless response.body.blank?
      end
    end
  end
end
