class PostSub < ActiveRecord::Base
  # validates :post_id, presence: true
  validates :sub_id, presence: true

  belongs_to(:post)
  belongs_to(:sub)
end
