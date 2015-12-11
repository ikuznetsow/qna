require 'rails_helper'

feature 'Browse question with related answers', %q{
  In order to ....
  As an User
  I want to be able answers related to questions
} do
  
  given(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, question: question) }
  given(:questions) { create_list(:question, 2, user: user) }

  scenario 'User browse questions list' do
    visit questions_path

    expect(page).to have_content 'Questions list'
    expect(page).to have_content questions.first.title
  end


  scenario 'User browse question with related answers' do
    visit question_path(question)

    expect(page).to have_content answer.body
  end
end