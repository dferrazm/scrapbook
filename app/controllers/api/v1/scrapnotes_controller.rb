module Api
  module V1
    class ScrapnotesController < BaseController
      include Api::CRUD

      before_action :authorize_user_from_params, except: [:index, :show]

      private

      def authorize_user_from_params
        if (params[:user_id] != current_user.id.to_s) && !current_user.admin?
          raise Api::Errors::Forbidden
        end
      end

      def permitted_params
        params.require(:scrapnote).permit(:content, :humour_id).merge(user: current_user)
      end
    end
  end
end
