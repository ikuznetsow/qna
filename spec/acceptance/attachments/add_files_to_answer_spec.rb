require 'acceptance_helper'

feature 'Add files to answer', %q{
  In order to better describe my answer
  As an authenticated user
  I want to be able to attach files
} do
  
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'Authenticated user adds file to own answer', js: true do
    fill_in 'Your answer', with: 'My answer'
    attach_file 'File', "#{Rails.root}/public/robots.txt"
    click_on 'Create Answer'

    within '.answers' do
      expect(page).to have_link 'robots.txt', href: '/uploads/attachment/file/1/robots.txt'
    end
  end

  scenario 'User add attachment to existing answer', js: true 
  scenario 'User deletes attachment from answer', js: true
end