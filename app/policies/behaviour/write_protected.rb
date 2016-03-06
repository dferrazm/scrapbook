module Policies
  module Behaviour
    module WriteProtected
      def index?
        true
      end

      def show?
        true
      end

      def create?
        current_user.admin?
      end

      def update?
        current_user.admin?
      end

      def destroy?
        current_user.admin?
      end
    end
  end
end
