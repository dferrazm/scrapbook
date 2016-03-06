class ScrapnotePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    !current_user.guest?
  end

  def update?
    admin_or_record_from_normal_user?
  end

  def destroy?
    admin_or_record_from_normal_user?
  end

  private

  def admin_or_record_from_normal_user?
    current_user.admin? ||
    (current_user.normal? && scrapnote_from_user?)
  end

  def scrapnote_from_user?
    current_user.scrapnotes.where(id: target.id).exists?
  end
end
