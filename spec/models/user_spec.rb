require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'creation' do
    before :each do
      @cena = User.create(name: 'John Doe', photo: 'https://picsum.photos/200/300', bio: 'I am John Doe')

      @post1 = Post.create(title: 'WWE Champion', text: 'The champ is hereeee! Welcome to the new Raw. Raw is Cena!',
                           author: @cena)
      @post2 = Post.create(title: 'To all challengers', text: 'If you want some, come get some!', author: @cena)
      @post3 = Post.create(title: 'The new WWE title', text: 'The new WWE title is here. It is the best title ever!',
                           author: @cena)
      @post4 = Post.create(title: 'To all my fans', text: 'Thank you for all your support!', author: @cena)
    end

    it "name can't be blank" do
      @cena.name = nil
      expect(@cena).to_not be_valid
    end

    it "photo can't be blank" do
      @cena.photo = nil
      expect(@cena).to_not be_valid
    end

    it "bio can't be blank" do
      @cena.bio = nil
      expect(@cena).to_not be_valid
    end

    it 'posts_counter must be an integer' do
      @cena.posts_counter = 'a'
      expect(@cena).to_not be_valid
    end

    it 'posts_counter must be greater than or equal to 0' do
      @cena.posts_counter = -1
      expect(@cena).to_not be_valid
    end

    it 'three_recent_posts must return 3 most recent posts' do
      expect(@cena.three_recent_posts).to eq([@post4, @post3, @post2])
    end
  end
end
