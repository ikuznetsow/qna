require 'rails_helper'

feature 'Questions actions', %q{
  In order to interact with community
  As an (Authenticated/non-) user
  I want to be able to CRUD questions
} do
  
  given!(:questions) { create_list(:question, 2, user: user) }
  given(:question) { create(:question, user: user) }
  given(:user) { create(:user) }

  scenario 'User browse questions list' do
    visit questions_path

    expect(page).to have_content 'Questions list'
    expect(page).to have_content questions.first.title
  end

  scenario 'Non-authenticated user trying to create question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in'
  end

  scenario 'Authenticated user creates question' do
    sign_in(user)
    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test text'
    click_on 'Create'

    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Authenticated user trying to delete his question' do
    sign_in(user)
    visit question_path(question)
    click_on 'Delete question'

    expect(page).to have_content 'Question was deleted'
    expect(page).to_not have_content question.title
  end

end