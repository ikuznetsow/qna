require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  
  describe 'POST #create' do
    sign_in_user
    let(:question) { create(:question, user: @user) } 
    let!(:answer) { create(:answer, question: question, user: @user) }
    
    context 'with valid attributes' do
      it 'saves a new answer to database' do
        expect {
         post :create, answer: attributes_for(:answer), question_id: question, format: :js
         }.to change(question.answers, :count).by(1) 
      end
      it 'saved answer related to current user' do
        post :create, answer: attributes_for(:answer), question_id: question, format: :js
        expect(question.answers.last.user_id).to eq @user.id                    #to review
      end
      it 'render template create' do
        post :create, answer: attributes_for(:answer), question_id: question, format: :js
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'should not create new answer' do
        expect {
         post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js 
         }.to_not change(Answer, :count)
      end
      it 'render template create' do
        post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user
    let!(:question) { create(:question) } 
    let!(:answer) { create(:answer, question: question, user: @user) }
    # let(:other_user) { create(:other_user) }
    let(:other_answer) { create(:answer, question: question, user: other_user) }

    it 'assigns the requested answer to @answer' do
      patch :update, id: answer, question_id: answer.question, answer: attributes_for(:answer), format: :js
      expect(assigns(:answer)).to eq answer
      expect(assigns(:question)).to eq question
    end

    it 'changes answer attributes' do
      patch :update, id: answer, question_id: answer.question, answer: { body: 'new body' }, format: :js
      answer.reload
      expect(answer.body).to eq 'new body'
    end

    it 'render update template' do
      patch :update, id: answer, question_id: answer.question, answer: attributes_for(:answer), format: :js
      expect(response).to render_template :update
    end
    # context 'own answer with valid attributes' do
    #   it 'changes answer attributes' do
    #     patch :update, question_id: answer.question_id, id: answer.id, answer: { body: 'Updated body' }
    #     answer.reload
    #     expect(answer.body).to eq 'Updated body'
    #   end
    # end
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
