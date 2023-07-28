class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :update_comments_counter
  after_destroy { update_pcomments_counter(false) }
  
  validates :author, :post, :text, presence: true
  validates :text, length: { minimum: 1, maximum: 250 }


  def update_comments_counter(increment = true)
    if increment
      author.increment!(:posts_counter)
    else
      author.decrement!(:posts_counter)
    end
  end
end
