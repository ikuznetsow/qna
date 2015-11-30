require 'rails_helper'

feature 'User log out', %q{
  In order to close session
  As an Loggedin User
  I want to be able to logout
} do

  given(:user) { create(:user) }
  
  scenario 'Loggedin user trying to log out' do
    sign_in(user)
    click_on 'Log out'

    expect(page).to have_content 'Signed out successfully'
    expect(current_path).to eq root_path
  end
end