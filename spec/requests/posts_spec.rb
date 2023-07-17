require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET' do
    before :all do
      @taker = User.create(name: 'The Undertaker', photo: 'https://picsum.photos/200/300', bio: 'The Phenom')
    end

    describe '/posts#index' do
      before :each do
        get user_posts_path(@taker)
      end

      it 'should return a successful response' do
        expect(response).to have_http_status(200)
      end

      it 'should render the index template' do
        expect(response).to render_template(:index)
      end

      it 'should include the placeholder text' do
        expect(response.body).to include('A list of posts by a given user')
      end
    end

    describe '/posts#show' do
      before :each do
        @post = Post.create(title: 'The Streak', text: 'The Streak is over!', author: @taker)
        get user_post_path(@taker, @post)
      end

      it 'should return a successful response' do
        expect(response).to have_http_status(200)
      end

      it 'should render the show template' do
        expect(response).to render_template(:show)
      end

      it 'should include the placeholder text' do
        expect(response.body).to include('Post details')
      end
    end
  end
end
