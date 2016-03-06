require_relative 'behaviour/write_protected'

class UserPolicy < ApplicationPolicy
  include Policies::Behaviour::WriteProtected
end
