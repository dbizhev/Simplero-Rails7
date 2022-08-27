class Post < ApplicationRecord
  belongs_to :member
  belongs_to :group
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :content, presence: true
end
