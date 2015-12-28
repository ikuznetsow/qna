require 'acceptance_helper'

feature 'Edit answers' do

  given(:user) { create(:user) }
  # given(:other_user) { create(:other_user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'Non-authenticated user trying to edit answers' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit answer'
  end

  describe 'Authenticated user' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'trying to edit others answers' 
    # do

    #   expect(page).to_not have_link 'Edit answer'
    # end

    scenario 'edits own answers', js: true do
      # debugger

      within '.answers' do
        click_on 'Edit answer'
        fill_in 'Edited answer', with: 'Updated body'
        click_on 'Save answer'

        expect(page).to have_content 'Updated body'
        expect(page).to_not have_content answer.body
        expect(page).to_not have_selector 'textarea'
      end
      
      expect(page).to have_content 'Your answer was successfully updated'
    end
  end
end