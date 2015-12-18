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
      it 'saved answer related to current user' do
        post :create, question_id: question, answer: attributes_for(:answer) 
        expect(question.answers.last.user_id).to eq @user.id                    #to review
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

  describe 'PATCH #update' do
    sign_in_user
    let(:question) { create(:question, user: @user) } 
    let!(:answer) { create(:answer, question: question, user: @user) }
    let(:other_user) { create(:other_user) }
    let(:other_answer) { create(:answer, question: question, user: other_user) }

    context 'own answer with valid attributes' do
      it 'changes answer attributes' do
        patch :update, question_id: answer.question_id, id: answer.id, answer: { body: 'Updated body' }
        answer.reload
        expect(answer.body).to eq 'Updated body'
      end

      it 'redirects to question_show view' do
        patch :update, question_id: answer.question_id, id: answer.id, answer: { body: 'Updated body' }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
    
    it 'should not change own answer with invalid attributes' do
      patch :update, question_id: answer.question_id, id: answer.id, answer: { body: nil }
      answer.reload
      expect(answer.body).to eq answer.body
    end

    it 'should not change others answers' do
      patch :update, question_id: other_answer.question_id, id: other_answer.id, answer: { body: 'Updated body' }
      answer.reload
      expect(answer.body).to eq answer.body
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    let(:question) { create(:question, user: @user) } 
    let!(:answer) { create(:answer, question: question, user: @user) }
    let(:other_user) { create(:other_user) }
    let!(:other_answer) { create(:answer, question: question, user: other_user) }

    it 'deletes own question' do
      expect { delete :destroy, question_id: answer.question_id, id: answer.id }.to change(question.answers, :count).by(-1)
    end

    it 'should not delete others answers' do
      expect { delete :destroy, question_id: other_answer.question_id, id: other_answer.id }.
        to_not change(Answer, :count)
    end
  end
end
