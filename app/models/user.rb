class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :recoverable, :rememberable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable

  has_many :groups, foreign_key: 'owner_id', dependent: :destroy
  has_many :memberships, dependent: :destroy, class_name: 'Member'
  has_many :membership_groups, through: :memberships, source: :group

  validates :name, presence: true
end
