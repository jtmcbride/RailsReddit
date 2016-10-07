class Sub < ActiveRecord::Base
  validates :title, uniqueness: true, presence: true
  validates :moderator_id, presence: true

  belongs_to :moderator,  class_name: :User
end