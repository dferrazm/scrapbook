require_relative 'behaviour/write_protected'

class MoodPolicy < ApplicationPolicy
  include Policies::Behaviour::WriteProtected
end
