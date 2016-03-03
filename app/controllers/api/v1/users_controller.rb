module Api
  module V1
    class UsersController < ApplicationController
      def index
        render :index, locals: { users: User.all }
      end

      def create
        user = User.new(user_params)
        save_and_respond(user)
      end

      def update
        user.assign_attributes(user_params)
        save_and_respond(user)
      end

      def destroy
        render partial: 'user', locals: { user: user.destroy }
      end

      private

      def user
        @user ||= User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:name)
      end

      def save_and_respond(user)
        if user.save
          render partial: 'user', locals: { user: user }
        else
          render json: user.errors.messages, status: 400
        end
      end
    end
  end
end