require 'rails_helper'

feature 'Create answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, question: question, user: user) }

  scenario 'Authenticated user creates answer', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'Your answer', with: answer.body
    click_on 'Create Answer'
    
    expect(current_path).to eq question_path(question)
    expect(page).to have_content answer.body
    # expect(page).to have_content 'You answer was successfully created'
  end

  scenario 'Non-authenticated user trying to create answer' do
    visit question_path(question)
    expect(page).to_not have_link 'Create answer'
  end
end