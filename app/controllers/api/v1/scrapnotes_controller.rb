module Api
  module V1
    class ScrapnotesController < BaseController
      include Api::CRUD

      private

      def records_collection
        current_user.scrapnotes
      end

      def permitted_params
        params.require(:scrapnote).permit(:content, :humour_id).merge(user: current_user)
      end
    end
  end
end
