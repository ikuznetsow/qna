require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
	describe 'GET #index'	do
		let(:user) { create(:user) }
		let(:questions) { create_list(:question, 2, user: user) } 

		before { get :index } 
		
		it 'populates array of all questions' do
			expect(assigns(:questions)).to match_array(questions)
		end
		
		it 'renders index view' do
			expect(response).to render_template :index
		end
	end

	describe 'GET #show' do
		let(:user) { create(:user) }
		let(:question) { create(:question, user: user) } 

		before { get :show, id: question }

		it 'assigns requested question to @question' do
			expect(assigns(:question)).to eq question	
		end

		it 'assigns new answer to question' do
			expect(assigns(:answer)).to be_a_new(Answer)
		end
		
		it 'renders show view' do
			expect(response).to render_template :show
		end
	end

	describe 'GET #new' do
		sign_in_user
		before { get :new }

		it 'assigns a new question to @question' do
			expect(assigns(:question)).to be_a_new(Question)
		end

		it 'renders new view' do
			expect(response).to render_template :new
		end
	end

	describe 'GET #edit' do
		sign_in_user
		let(:question) { create(:question, user: @user) }

		before { get :edit, id: question }

		it 'assigns requested questions to @question' do
			expect(assigns(:question)).to eq question	
		end
		
		it 'renders edit view' do
			expect(response).to render_template :edit
		end
	end

	describe 'PATCH #update' do
		sign_in_user
		let(:question) { create(:question, user: @user) }
		let(:other_user) { create(:other_user) }
		let(:others_question) { create(:question, user: other_user) }

		context 'own question with valid attributes' do
      it 'changes question attributes' do
        patch :update, id: question, question: { title: 'Updated title', body: 'Updated body' }
        question.reload
        expect(question.title).to eq 'Updated title'
        expect(question.body).to eq 'Updated body'
      end

			it 'redirects to show view' do
        patch :update, id: question, question: { title: 'Updated title', body: 'Updated body' }
				expect(response).to redirect_to question_path(assigns(:question))
			end
		end
		
		context 'own question with invalid attributes' do
			it 'should not change question attributes' do
        patch :update, id: question, question: { title: nil, body: 'Updated body' }
        question.reload
        expect(question.title).to eq question.title
        expect(question.body).to eq question.body
      end
		end

		it 'should not edit others questions' do
			patch :update, id: others_question, others_question: { title: 'Updated title', body: 'Updated body' }
      expect(question.title).to_not eq 'Updated title'
      expect(question.body).to_not eq 'Updated body'
		end
	end

	describe 'POST #create' do
		sign_in_user
		
		context 'with valid attributes' do
			it 'saves a new question to database' do
				expect{ post :create, question: attributes_for(:question) }.to change(@user.questions, :count).by(1)
			end

			it 'redirects to show view' do
				post :create, question: attributes_for(:question)
				expect(response).to redirect_to question_path(assigns(:question))
			end
		end
		
		context 'with invalid attributes' do
			it 'doesnot saves a new question to database' do
				expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
			end

			it 'rerenders new view' do
				post :create, question: attributes_for(:invalid_question)
				expect(response).to render_template :new
			end
		end
	end

	describe 'DELETE #destroy' do
    sign_in_user
		let!(:question) { create(:question, user: @user) }
		let!(:other_user) { create(:other_user) }
		let!(:others_question) { create(:question, user: other_user) }

		it 'deletes own question' do
      expect { delete :destroy, id: question }.to change(@user.questions, :count).by(-1)
		end

    it 'should not delete others question' do
      expect{ delete :destroy, id: others_question }.to_not change(Question, :count)
    end
	end
end
