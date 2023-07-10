require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'creation' do
    before :each do
      @austin = User.create(name: 'Stone Cold', photo: 'https://picsum.photos/austin.jpg', bio: 'I am the rattlesnake')

      @post = Post.create(title: 'The toughest SOB', text: 'I am the toughest SOB in the WWE!', author: @austin)

      @comment1 = Comment.create(text: 'I was out with a couple of my buddies.', author: @austin, post: @post)
      @comment2 = Comment.create(text: 'We drank some beer.', author: @austin, post: @post)
      @comment3 = Comment.create(text: 'We drank some more beer.', author: @austin, post: @post)
      @comment4 = Comment.create(text: 'And some more beer.', author: @austin, post: @post)
      @comment5 = Comment.create(text: 'We drank all the beer.', author: @austin, post: @post)
      @comment6 = Comment.create(text: 'And then we raised some hell.', author: @austin, post: @post)
    end

    it "title can't be blank" do
      @post.title = nil
      expect(@post).to_not be_valid
    end

    it "text can't be blank" do
      @post.text = nil
      expect(@post).to_not be_valid
    end

    it 'title must be at least 1 character and at most 250 characters' do
      @post.title = ''
      expect(@post).to_not be_valid
      @post.title = 'a' * 251
      expect(@post).to_not be_valid
    end

    it 'text must be at least 1 character and at most 500 characters' do
      @post.text = ''
      expect(@post).to_not be_valid
      @post.text = 'a' * 501
      expect(@post).to_not be_valid
    end

    it 'likes_counter must be an integer' do
      @post.likes_counter = 'a'
      expect(@post).to_not be_valid
    end

    it 'likes_counter must be greater than or equal to 0' do
      @post.likes_counter = -1
      expect(@post).to_not be_valid
    end

    it 'comments_counter must be an integer' do
      @post.comments_counter = 'a'
      expect(@post).to_not be_valid
    end

    it 'comments_counter must be greater than or equal to 0' do
      @post.comments_counter = -1
      expect(@post).to_not be_valid
    end

    it 'five_recent_comments must return 5 most recent comments' do
      expect(@post.five_recent_comments).to eq([@comment6, @comment5, @comment4, @comment3, @comment2])
    end

    it 'update_post_counter must update the posts_counter of the author' do
      expect(@austin.posts_counter).to eq(1)
    end
  end
end
