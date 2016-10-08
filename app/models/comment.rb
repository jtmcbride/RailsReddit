# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :string
#  author_id         :integer          not null
#  post_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_comment_id :integer
#

class Comment < ActiveRecord::Base
  validates :author_id, :post_id, presence: true

  belongs_to :post
  belongs_to :author, class_name: :User
  has_many :replies, class_name: :Comment, foreign_key: :parent_comment_id
  belongs_to :parent_comment, class_name: :Comment
  has_many :votes, as: :votable

  def upvote
    self.votes.create(value: 1)
  end

  def downvote
    self.votes.create(value: -1)
  end

  def score
    self.votes.inject(0) { |memo, vote| memo += vote.value }
  end
end
