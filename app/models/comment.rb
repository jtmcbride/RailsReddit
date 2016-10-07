class Comment < ActiveRecord::Base
  validates :author_id, :post_id, presence: true

  belongs_to :post
  belongs_to :author, class_name: :User
  has_many :replies, class_name: :Comment, foreign_key: :parent_comment_id
  belongs_to :parent_comment, class_name: :Comment
end
