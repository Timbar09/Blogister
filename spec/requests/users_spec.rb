require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET' do
    before :all do
      @cena = User.create(name: 'John Doe', photo: 'https://picsum.photos/200/300', bio: 'You cant see me!')
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
        expect(response.body).to include('User list')
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
        expect(response.body).to include('A given user profile')
      end
    end
  end
end
