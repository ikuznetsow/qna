require 'acceptance_helper'

feature 'Add files to question', %q{
  In order to better describe my question
  As an authenticated user
  I want to be able to attach files
} do
  
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'Authenticated user adds file to own question' do
    fill_in 'Title', with: question.title
    fill_in 'Body', with: question.body
    attach_file 'File', "#{Rails.root}/spec/files/rails_helper.rb"
    click_on 'Create'

    expect(page).to have_content 'rails_helper.rb'
  end
end