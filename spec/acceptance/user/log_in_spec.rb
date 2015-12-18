require 'rails_helper'

feature 'User log in', %q{
  In order to be able to ask/answer qustions
  As an User
  I want to be able to login
} do

  given(:user) { create(:user) }
  
  scenario 'Registered user trying to log in' do 
    sign_in(user)

    expect(page).to have_content 'Signed in successfully'
    expect(current_path).to eq root_path
  end

  scenario 'Non-Registered user trying to log in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wronguser@test.com'
    fill_in 'Password', with: '1234567'
    click_on 'Log in'

    expect(page).to have_content 'Invalid email or password'
    expect(current_path).to eq new_user_session_path
  end

end