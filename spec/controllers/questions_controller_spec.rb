require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
	describe 'GET #index'	do
		let(:questions) { create_list(:question, 2) } 

		before { get :index } 
		
		it 'populates array of all questions' do
			expect(assigns(:questions)).to match_array(questions)
		end
		
		it 'renders index view' do
			expect(response).to render_template :index
		end
	end

	describe 'GET #show' do
		let(:question) { create(:question) } 

		before { get :show, id: question }

		it 'assigns requested questions to @question' do
			expect(assigns(:question)).to eq question	
		end
		
		it 'renders show view' do
			expect(response).to render_template :show
		end
	end

	describe 'GET #new' do
		before { get :new }

		it 'assigns a new question to @question' do
			expect(assigns(:question)).to be_a_new(Question)
		end

		it 'renders new view' do
			expect(response).to render_template :new
		end
	end

	describe 'POST #create' do
		context 'with valid attributes' do
			it 'saves a new question to database' do
				expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
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
