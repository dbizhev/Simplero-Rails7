class Member < ApplicationRecord
  belongs_to :group, optional: false
  belongs_to :user, optional: false

  enum status: Members::Status::VALID_STATUSES, _prefix: true
end
