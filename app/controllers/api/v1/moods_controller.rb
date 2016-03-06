module Api
  module V1
    class MoodsController < BaseController
      include Api::CRUD

      before_action :authorize_action

      private

      def permitted_params
        params.require(:mood).permit(:description)
      end
    end
  end
end
