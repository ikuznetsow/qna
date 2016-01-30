require 'acceptance_helper'

feature 'Add files to answer', %q{
  In order to better describe my answer
  As an authenticated user
  I want to be able to attach files
} do
  
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'Authenticated user adds files to own answer', js: true do
    fill_in 'Your answer', with: 'My answer'
    attach_file 'File', "#{Rails.root}/public/robots.txt"
    click_on 'Add file'
    all("input[type='file']").last.set("#{Rails.root}/public/favicon.ico")
    click_on 'Create Answer'

    within '.answers' do
      expect(page).to have_link 'robots.txt', href: '/uploads/attachment/file/1/robots.txt'
      expect(page).to have_link 'favicon.ico', href: '/uploads/attachment/file/2/favicon.ico'
    end
  end

  scenario 'User add attachment to existing answer', js: true do
    fill_in 'Your answer', with: 'My answer'
    click_on 'Create Answer'
    visit question_path(question)
    within '.answers' do
      click_on 'Edit answer'
      click_on 'Add file'
      attach_file 'File', "#{Rails.root}/public/robots.txt"
      click_on 'Save answer'

      expect(page).to have_link 'robots.txt', href: '/uploads/attachment/file/1/robots.txt'
    end
  end

  scenario 'User deletes attachment from answer', js: true do
    fill_in 'Your answer', with: 'My answer'
    attach_file 'File', "#{Rails.root}/public/robots.txt"
    click_on 'Create Answer'
    visit question_path(question)
    within '.answers' do
      click_on 'Edit answer'
      click_on 'Delete file'
      click_on 'Save answer'

      expect(page).to_not have_link 'robots.txt', href: '/uploads/attachment/file/1/robots.txt'
    end
  end
end