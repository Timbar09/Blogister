class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_likes_counter

  validates :author, :post, presence: true

  private

  def update_likes_counter
    post.increment!(:likes_counter)
  end
end
