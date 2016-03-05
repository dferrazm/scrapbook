module Api
  module V1
    class ScrapnotesController < ApplicationController
      def index
        render :index, locals: { scrapnotes: current_user.scrapnotes }
      end

      def show
        respond_with(scrapnote)
      end

      def create
        scrapnote = current_user.scrapnotes.build(scrapnote_params)
        save_and_respond(scrapnote)
      end

      def update
        scrapnote.assign_attributes(scrapnote_params)
        save_and_respond(scrapnote)
      end

      def destroy
        render partial: 'scrapnote', locals: { scrapnote: scrapnote.destroy }
      end

      private

      def current_user
        @current_user ||= User.find(params[:user_id])
      end

      def scrapnote
        @scrapnote ||= current_user.scrapnotes.find(params[:id])
      end

      def scrapnote_params
        params.require(:scrapnote).permit(:content, :humour_id)
      end

      def save_and_respond(scrapnote)
        if scrapnote.save
          respond_with(scrapnote)
        else
          render json: scrapnote.errors.messages, status: 400
        end
      end

      def respond_with(scrapnote)
        render partial: 'scrapnote', locals: { scrapnote: scrapnote }
      end
    end
  end
end
