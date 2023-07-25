RSpec.describe 'Users', type: :system, js: true do
    describe 'index page' do
      before(:example) do
        @miles = User.create(name: 'Miles', photo: '/assets/default_user.jpg', bio: 'I am a test user.')
        @john = User.create(name: 'John', photo: '/assets/default_user.jpg', bio: 'I am a second test user.')
        visit users_path
      end
  
      it 'should render user information' do
        expect(page).to have_content(@miles.name)
        expect(page).to have_content(@john.name)
  
        expect(page).to have_css("img[src*='default_user.jpg']")
  
        expect(page).to have_content('Posts: 0')
      end
  
      it 'should redirect to the user page when a username is clicked' do
        find('.user_card', text: @miles.name).click
        expect(page).to have_current_path(user_path(@miles))
      end
    end
  end