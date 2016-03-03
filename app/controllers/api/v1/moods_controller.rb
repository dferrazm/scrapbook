module Api
  module V1
    class MoodsController < ApplicationController
      def index
        render :index, locals: { moods: Mood.all }
      end

      def show
        respond_with(mood)
      end

      def create
        mood = Mood.new(mood_params)
        save_and_respond_with(mood)
      end

      def update
        mood.assign_attributes(mood_params)
        save_and_respond_with(mood)
      end

      def destroy
        render partial: 'mood', locals: { mood: mood.destroy }
      end

      private

      def mood
        @mood ||= Mood.find(params[:id])
      end

      def mood_params
        params.require(:mood).permit(:description)
      end

      def save_and_respond_with(mood)
        if mood.save
          respond_with(mood)
        else
          render json: mood.errors.messages, status: 400
        end
      end

      def respond_with(mood)
        render partial: 'mood', locals: { mood: mood }
      end
    end
  end
end
