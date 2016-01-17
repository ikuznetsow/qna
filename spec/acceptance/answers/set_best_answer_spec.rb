require 'acceptance_helper'

feature 'Select best answer', %q{
  In order to show what answer worked
  As the question's author
  I want to be able to select best answer
} do
  
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given!(:answers) { create_list(:answer, 3, question: question) }
  given(:other_user) { create(:user) }

  scenario 'Non-authenticated user trying to select best answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Set best'
  end

  describe 'Authenticated user' do
    scenario 'trying to set best on others questions' do
      sign_in(other_user)
      visit question_path(question)
      within ".answers" do

        expect(page).to_not have_link 'Set Best'
      end
    end

    scenario 'set best answer for own question and shown first', js: true do
      sign_in(user)
      visit question_path(question)
      within "#answer-#{answers.first.id}" do          
        click_on 'Set best'

        expect(page).to_not have_link 'Set best'
        expect(page).to have_content 'Best answer'
      end
      expect(page.find(:xpath, '(//div[@class="answers"]/div)[1]')).to have_content 'Best answer'
      expect(page).to have_content "Best answer has been set"
    end

    scenario 'set best answer for antoher own question', js: true do
      sign_in(user)
      visit question_path(question)
      within "#answer-#{answers.first.id}" do          
        click_on 'Set best'
      end
      within "#answer-#{answers.second.id}" do          
        click_on 'Set best'
      end
      within '.answers' do
        expect(page).to have_content('Best answer', count: 1)
      end
    end
  end
end