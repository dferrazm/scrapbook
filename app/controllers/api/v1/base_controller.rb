module Api
  module V1
    class BaseController < ApplicationController
      include Api::Authentication
      include Api::Authorization
      include Api::Errors
    end
  end
end
