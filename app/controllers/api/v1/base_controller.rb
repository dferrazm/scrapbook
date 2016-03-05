module Api
  module V1
    class BaseController < ApplicationController
      include Api::Authenticable

      rescue_from ActiveRecord::RecordNotFound do
        render nothing: true, status: 404
      end
    end
  end
end
