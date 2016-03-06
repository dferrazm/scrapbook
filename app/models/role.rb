class Role
  GUEST = 'guest'
  NORMAL = 'normal'
  ADMIN = 'admin'

  LIST = [GUEST, NORMAL, ADMIN]

  module Behaviour
    extend ActiveSupport::Concern

    included do
      validates :role, inclusion: { in: Role::LIST }
    end

    LIST.each do |role_value|
      define_method("#{role_value}?") do
        role.to_s == role_value
      end
    end
  end
end
