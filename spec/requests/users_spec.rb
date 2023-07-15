require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET' do
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
  end
end