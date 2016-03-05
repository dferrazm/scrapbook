module Api
  module V1
    class ScrapnotesController < BaseController
      include Api::CRUD

      before_action :authorize_user

      private

      def authorize_user
        if params[:user_id] != current_user.id.to_s
          raise Api::Errors::Forbidden
        end
      end

      def records_collection
        current_user.scrapnotes
      end

      def permitted_params
        params.require(:scrapnote).permit(:content, :humour_id).merge(user: current_user)
      end
    end
  end
end
