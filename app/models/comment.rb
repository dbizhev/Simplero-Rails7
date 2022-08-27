class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :parent, optional: true, class_name: 'Comment'
  has_many :replies, class_name: 'Comment', foreign_key: 'parent_id'
  validates :content, presence: true
end
