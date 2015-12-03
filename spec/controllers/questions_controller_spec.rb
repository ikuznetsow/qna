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

		it 'assigns requested questions to @question' do
			expect(assigns(:question)).to eq question	
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

	describe 'POST #create' do
		sign_in_user
		context 'with valid attributes' do
			it 'saves a new question to database' do
				expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)

				# question.user_id == current_user
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
end
