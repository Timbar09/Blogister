require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET' do
    before :all do
      @cena = User.create(name: 'John Cena', photo: 'https://picsum.photos/200/300', bio: 'You cant see me!')
      @post = Post.create(title: 'The Streak', text: 'The Streak is over!', author: @cena)
    end

    describe '/users#index' do
      before :each do
        get users_path
      end

      it 'should return a successful response' do
        expect(response).to have_http_status(200)
      end

      it 'should render the index template' do
        expect(response).to render_template(:index)
      end

      it 'should include the placeholder text' do
        expect(response.body).to include(@cena.name)
      end
    end

    describe '/users#show' do
      before :each do
        get user_path(@cena)
      end

      it 'should return a successful response' do
        expect(response).to have_http_status(200)
      end

      it 'should render the show template' do
        expect(response).to render_template(:show)
      end

      it 'should include the placeholder text' do
        expect(response.body).to include(@post.title)
      end
    end   
  end
end