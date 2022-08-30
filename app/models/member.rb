class Member < ApplicationRecord
  belongs_to :group, optional: false
  belongs_to :user, optional: false
  has_many :posts, dependent: :destroy

  enum status: Members::Status::VALID_STATUSES, _prefix: true
end
