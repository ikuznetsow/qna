require 'rails_helper'

feature 'Create answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  scenario 'Non-authenticated user trying to create answer' do
    visit question_path(question)
    expect(page).to_not have_link 'Create answer'
  end

  scenario 'Authenticated user creates answer'
end