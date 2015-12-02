require 'rails_helper'

feature 'Question with related Answers', %q{
  In order to ....
  As an User
  I want to be able answers related to questions
} do
  
  given!(:question) { create(:question) }
  given(:answer) { create(:answer, question: question) }

  scenario 'User browse question with related answers' do
    visit question_path(question)

    expect(page).to have_content answer.body
  end
end