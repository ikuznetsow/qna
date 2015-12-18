require 'rails_helper'

feature 'Create question', %q{
  In order to get answers from community
  As an authenticated user
  I want to be able to ask question
} do
  
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Non-authenticated user trying to create question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in'
  end

  scenario 'Authenticated user creates question' do
    sign_in(user)
    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: question.title
    fill_in 'Body', with: question.body
    click_on 'Create'

    expect(page).to have_content 'Your question successfully created'
    expect(page).to have_content question.title
    expect(page).to have_content question.body
  end
end