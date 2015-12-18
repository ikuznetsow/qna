require 'rails_helper'

feature 'User register', %q{
  In order to be able to ask/answer qustions
  As an User
  I want to be able to register
} do

  scenario 'User trying to sign up' do 
    visit new_user_registration_path
    fill_in 'Email', with: 'user123@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'
    click_on 'Sign up'

    expect(page).to have_content 'You have signed up successfully'
    expect(current_path).to eq root_path
  end

end
