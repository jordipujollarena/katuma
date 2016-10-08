module Suppliers
  class GroupPolicy < Shared::ApplicationPolicy
    def show?
      Membership.where(
        basic_resource_group_id: record.id,
        user_id: user.id,
        role: [Membership::ROLES[:admin], Membership::ROLES[:member]]
      ).any?
    end

    def index?
      show?
    end

    def create?
      false
    end

    def update?
      false
    end

    def destroy?
      false
    end
  end
end
