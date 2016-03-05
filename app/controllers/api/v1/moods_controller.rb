module Api
  module V1
    class MoodsController < BaseController
      include Api::CRUD

      private

      def permitted_params
        params.require(:mood).permit(:description)
      end
    end
  end
end
