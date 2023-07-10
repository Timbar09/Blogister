require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'creation' do
    before :each do
      @rock = User.create(name: 'The Rock', photo: 'https://picsum.photos/rock.jpg',
                          bio: 'If you smell what The Rock is cooking')
      @austin = User.create(name: 'Stone Cold', photo: 'https://picsum.photos/austin.jpg', bio: 'I am the rattlesnake')

      @post = Post.create(title: "The People's Champ",
                          text: "If you're not down with The Rock, I got two words for ya: SUCK IT!", author: @rock)

      @austin_like = Like.create(author: @austin, post: @post)
      @rock_like = Like.create(author: @rock, post: @post)
    end

    it "author can't be blank" do
      @austin_like.author = nil
      expect(@austin_like).to_not be_valid
    end

    it "post can't be blank" do
      @austin_like.post = nil
      expect(@austin_like).to_not be_valid
    end

    it 'update_likes_counter must update the likes_counter of the post' do
      expect(@post.likes_counter).to eq(2)
    end
  end
end
