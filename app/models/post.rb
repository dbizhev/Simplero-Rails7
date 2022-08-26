class Post < ApplicationRecord
  belongs_to :member
  belongs_to :group
  validates :title, presence: true
  validates :content, presence: true
end
