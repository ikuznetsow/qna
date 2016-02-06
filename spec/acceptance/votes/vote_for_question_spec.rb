# featutre  Vote
#   describe  Authenticated user
#     context for others qustion
#       scenario  Can vote
#     context for own qustion
#       scenario  Can not vote
#   describe  Non-Authenticated user
#       scenario  Can not vote
# 
require 'acceptance_helper'

feature 'Vote for question', %q{
  In order to distinguish useful question
  As an authenticated user
  I want to be able to vote for it
} do
  
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:own_question) { create(:question, user: user) }
  
  describe  'Authenticated user' do
    before { sign_in user }
    context 'for others qustion' do
      before { visit question_path question }
      scenario 'can vote', js: true do
        within '#question .votes' do
          click_on '+'

          expect(page).to have_content '1'
          expect(page).to have_link 'Cancel vote'
        end
      end

      scenario  'can re-vote'
    end
    context 'for own qustion' do
      scenario  'can not vote'
    end
  end

  describe  'Non-Authenticated user' do
    scenario  'can not vote' #no vote links
      # within '#question-area' do
      #   expect(page).to have_link("+")
      #   expect(page).to have_link("-")
      # end
  end
end
