require 'acceptance_helper'

feature 'Delete questions' do
  
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:other_user) { create(:other_user) }

  scenario 'Authenticated user deletes own question' do
    sign_in(user)
    visit question_path(question)
    click_on 'Delete question'
    expect(page).to have_content 'Your question was deleted'
    expect(page).to_not have_content question.title
    expect(current_path).to eq questions_path
  end

  scenario 'Authenticated user trying to delete others question' do
    sign_in(other_user)
    visit question_path(question)
    expect(page).to_not have_link 'Delete question'
  end

  scenario 'Non-authenticated user trying to delete question' do
    visit question_path(question)
    expect(page).to_not have_link 'Delete question'
  end
end