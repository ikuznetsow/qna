require 'acceptance_helper'

feature 'Add files to question', %q{
  In order to better describe my question
  As an authenticated user
  I want to be able to attach files
} do
  
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:question_with_attachment) { create(:question, :with_attachment, user: user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'Authenticated user adds file to own question', js: true do
    fill_in 'Title', with: question.title
    fill_in 'Body', with: question.body
    attach_file 'File', "#{Rails.root}/public/robots.txt"
    click_on 'Create'

    expect(page).to have_link 'robots.txt', href: '/uploads/attachment/file/1/robots.txt'
  end

  scenario 'User adds 2 files to question', js: true do
    fill_in 'Title', with: question.title
    fill_in 'Body', with: question.body
    all("input[type='file']").first.set("#{Rails.root}/public/robots.txt")
    click_on 'Add file'
    all("input[type='file']").last.set("#{Rails.root}/public/favicon.ico")
    click_on 'Create'

    expect(page).to have_link 'robots.txt', href: '/uploads/attachment/file/1/robots.txt'
    expect(page).to have_link 'favicon.ico', href: '/uploads/attachment/file/2/favicon.ico'
  end


  scenario 'User updates question attachment', js: true do
    visit question_path(question_with_attachment)
      
    within '#question' do
      click_on 'Edit question'
      click_on 'Add file'
      attach_file 'File', "#{Rails.root}/public/favicon.ico"
      click_on 'Save question'
    end

    expect(page).to have_content 'Your question was successfully updated'
    expect(page).to have_link 'favicon.ico'
  end

end