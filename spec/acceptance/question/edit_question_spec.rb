require 'acceptance_helper'

feature 'Edit questions' do
  
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:other_user) { create(:other_user) }

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'Authenticated user trying to edit others question' do

      expect(page).to_not have_link 'Edit question'
    end 

    scenario 'Authenticated user edit own question' do
      within '#question' do
        click_on 'Edit question'
          fill_in 'Title', with: 'Updated title'
          fill_in 'Body', with: 'Updated body'
          click_on 'Save question'
        expect(page).to have_content 'Your question successfully updated'
        expect(page).to_not have_content question.title
        expect(page).to_not have_content question.body
        expect(page).to have_content 'Updated title'
        expect(page).to have_content 'Updated body'
      end
    end
  end 
  
  scenario 'Non-authenticated user trying to edit question' do
    visit question_path(question)
    expect(page).to_not have_link 'Edit question'
  end
end