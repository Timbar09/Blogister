class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_likes_counter
  after_destroy { update_likes_counter(false)}

  validates :author, :post, presence: true

  private

  def update_likes_counter(increment = true)
    if increment
      post.increment!(:likes_count)
    else
      post.decrement!(:likes_count)
    end
  end
  end
end
