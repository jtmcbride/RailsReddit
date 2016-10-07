class Comment < ActiveRecord::Base
  validates :author_id, :post_id, presence: true

  belongs_to :post
  belongs_to :author, class_name: :User
end
