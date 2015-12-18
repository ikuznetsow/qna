require 'rails_helper'

feature 'Delete answers' do

  given(:user) { create(:user) }
  given(:other_user) { create(:other_user) }
  given(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario  'Authenticated user trying to delete others answers' do
    sign_in(other_user)
    visit question_path(question)
    expect(page).to_not have_link 'Delete answer'
  end

  scenario  'Non-Authenticated user trying to delete answers' do
    visit question_path(question)
    expect(page).to_not have_link 'Delete answer'
  end

  scenario  'Authenticated user deletes own answers' do
    sign_in(user)
    visit question_path(question)
    click_on 'Delete answer'

    expect(page).to have_content 'Your answer was deleted'
    expect(page).to_not have_selector ("div#answer_#{answer.id}")
    expect(page).to_not have_content answer.body
  end
end