require 'rails_helper'

feature 'Create question', %q{
  In order to check questions list
  As an User
  I want to be able to see questions
} do
  
  given!(:questions) { create_list(:question, 2) }
  given(:user) { create(:user) }

  scenario 'User browse question' do
    visit questions_path

    expect(page).to have_content 'Questions list'
    expect(page).to have_content questions.first.title
  end
end