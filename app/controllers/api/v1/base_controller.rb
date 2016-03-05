module Api
  module V1
    class BaseController < ApplicationController
      include ::Authenticable

      rescue_from ActiveRecord::RecordNotFound do
        render nothing: true, status: 404
      end
    end
  end
end
