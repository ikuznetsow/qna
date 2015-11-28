require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }
  
  describe 'POST #create' do
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
end