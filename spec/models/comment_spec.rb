require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'creation' do
    before :each do
      @rock = User.create(name: 'The Rock', photo: 'https://picsum.photos/rock.jpg',
                          bio: 'If you smell what The Rock is cooking')
      @austin = User.create(name: 'Stone Cold', photo: 'https://picsum.photos/austin.jpg', bio: 'I am the rattlesnake')

      @post = Post.create(title: "The People's Champ",
                          text: "If you're not down with The Rock, I got two words for ya: SUCK IT!", author: @rock)

      @austin_comment = Comment.create(text: 'Is that so?', author: @austin, post: @post)
      @rock_comment = Comment.create(text: 'I am the most electrifying man in sports entertainment!', author: @rock,
                                     post: @post)
    end

    it "text can't be blank" do
      @austin_comment.text = nil
      expect(@austin_comment).to_not be_valid
    end

    it "author can't be blank" do
      @austin_comment.author = nil
      expect(@austin_comment).to_not be_valid
    end

    it "post can't be blank" do
      @austin_comment.post = nil
      expect(@austin_comment).to_not be_valid
    end

    it 'text must be at least 1 character and at most 250 characters' do
      @austin_comment.text = ''
      expect(@austin_comment).to_not be_valid
      @austin_comment.text = 'a' * 251
      expect(@austin_comment).to_not be_valid
    end

    it 'update_comments_counter must update the comments_counter of the post' do
      expect(@post.comments_counter).to eq(2)
    end
  end
end
