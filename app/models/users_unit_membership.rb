class UsersUnitMembership < ActiveRecord::Base

  ROLES = { admin: 1, member: 2, waiting: 3 }

  belongs_to :users_unit
  belongs_to :user

  validates :users_unit, :user, :role,
    presence: true
  validates :role,
    inclusion: { in: ROLES.values }
  validates :user_id,
    uniqueness: { scope: :users_unit_id }
end
