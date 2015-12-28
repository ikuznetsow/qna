require 'acceptance_helper'

feature 'Edit questions' do
  
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:other_user) { create(:other_user) }

  
  describe 'Authenticated user' do
    scenario 'trying to edit others question' do
      sign_in(other_user)
      visit question_path(question)

      expect(page).to_not have_link 'Edit question'
    end 

    scenario 'edit own question', js: true do
      sign_in(user)
      visit question_path(question)
      
      within '#question' do
        click_on 'Edit question'
        fill_in 'Title', with: 'Updated title'
        fill_in 'Body', with: 'Updated body'
        click_on 'Save question'

        expect(page).to_not have_content question.title
        expect(page).to_not have_content question.body
        expect(page).to have_content 'Updated title'
        expect(page).to have_content 'Updated body'
      end
      expect(page).to have_content 'Your question was successfully updated'
    end
  end 
  
  scenario 'Non-authenticated user trying to edit question' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit question'
  end
end