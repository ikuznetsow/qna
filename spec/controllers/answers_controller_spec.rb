require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  
  describe 'POST #create' do
    sign_in_user
    let(:question) { create(:question, user: @user) } 
    let!(:answer) { create(:answer, question: question, user: @user) }
    
    context 'with valid attributes' do
      it 'saves a new answer to database' do
        expect {
         post :create, question_id: question, answer: attributes_for(:answer) 
         }.to change(question.answers, :count).by(1)
      end
      it 'redirects to question show view' do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'should not create new answer' do
        expect {
         post :create, question_id: question, answer: attributes_for(:invalid_answer) 
         }.to_not change(question.answers, :count)
      end
      it 'redirects to question show view' do
        post :create, question_id: question, answer: attributes_for(:invalid_answer)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
  end


  describe 'DELETE #destroy' do
    sign_in_user
    let(:question) { create(:question, user: @user) } 
    let!(:answer) { create(:answer, question: question, user: @user) }
    # let(:foreign_answer) { create(:answer, question: question) }
    # let!(:other_user) { create(:other_user) }
    # let!(:others_question) { create(:question, user: other_user) }

    it 'deletes own question' do
      expect { delete :destroy, question_id: answer.question_id, id: answer.id }.to change(Answer, :count).by(-1)
      # if question.answers.count changed
    end
  end
end
