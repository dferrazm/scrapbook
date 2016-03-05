module Api
  module V1
    class UsersController < BaseController
      include Api::CRUD

      private

      def permitted_params
        params.require(:user).permit(:username, :password)
      end
    end
  end
end
