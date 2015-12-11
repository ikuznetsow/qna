require 'rails_helper'

feature 'Edit questions' do
  
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:other_user) { create(:other_user) }

  scenario 'Authenticated user edit own question' do
    sign_in(user)
    visit question_path(question)
    click_on 'Edit question'
      fill_in 'Title', with: 'Updated title'
      fill_in 'Body', with: 'Updatd body'
      click_on 'Save'
    expect(page).to have_content 'Your question successfully updated'
    expect(page).to_not have_content question.title
    expect(page).to_not have_content question.body
    expect(page).to have_content 'Updated title'
    expect(page).to have_content 'Updatd body'
  end

  scenario 'Authenticated user trying to edit others question' do
    sign_in(other_user)
    visit question_path(question)
    expect(page).to_not have_link 'Edit question'
  end

end