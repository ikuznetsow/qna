require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
	let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }
  
	describe 'GET #new' do
		before { get :new, question_id: question }

		it 'assigns a new answer to @answer' do
			expect(assigns(:answer)).to be_a_new(Answer)
		end

		it 'renders new view' do
			expect(response).to render_template :new
		end
	end

	describe 'POST #create' do
		context 'with valid attributes' do
			it 'saves a new answer to database' do
				expect { post :create, question_id: question, answer: attributes_for(:answer) }.to change(question.answers, :count).by(1)
			end
			it 'redirects to question show view' do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to question_path(assigns(:question))
      end
		end

		context 'with invalid attributes' 
	end
end
