class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_save :update_posts_counter
  after_destroy { update_posts_counter(false) }
  validates :title, :text, presence: true
  validates :title, length: { minimum: 1, maximum: 250 }
  validates :text, length: { minimum: 1, maximum: 500 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def five_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_posts_counter(increment: true)
    if increment
      author.increment!(:posts_counter)
    else
      author.decrement!(:posts_counter)
    end
  end
end
