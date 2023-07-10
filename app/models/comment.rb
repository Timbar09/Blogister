class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  default_scope -> { order(created_at: :desc) }

  after_save :update_comments_counter

  validates :author, :post, :text, presence: true
  validates :text, length: { minimum: 1, maximum: 250 }

  private

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
