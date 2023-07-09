class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  default_scope -> { order(created_at: :desc) }

  def five_recent_comments
    comments.limit(5)
  end
end
