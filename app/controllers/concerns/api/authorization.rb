module Api
  module Authorization
    include Pundit

    private

    def authorize_action
      authorize(authorizable_resource)
    rescue Pundit::NotAuthorizedError
      raise Api::Errors::Forbidden
    end
  end
end
