class Group < ApplicationRecord
  belongs_to :owner, optional: false, class_name: 'User'
  has_many :members, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  enum access: Groups::Access::VALID_ACCESSES, _prefix: true

  def member_exist?(user: nil)
    return false if user.blank?

    members.where(user_id: user.id).exists?
  end

  def get_member(user: nil)
    return false if user.blank?

    members.where(user_id: user.id).first
  end
end
