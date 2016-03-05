module Api
  module Errors
    extend ActiveSupport::Concern

    class Unauthorized < StandardError; end
    class Forbidden < StandardError; end

    included do
      rescue_from ActiveRecord::RecordNotFound do
        render nothing: true, status: 404
      end

      rescue_from Unauthorized do
        render nothing: true, status: 401
      end

      rescue_from Forbidden do
        render nothing: true, status: 403
      end
    end
  end
end
