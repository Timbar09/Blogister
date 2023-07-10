class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_comments_counter

  validates :author, :post, :text, presence: true
  validates :text, length: { minimum: 1, maximum: 250 }

  private

  def update_comments_counter
    post.increment!(:comments_counter)
  end
end
