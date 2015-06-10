require 'rails_helper'

describe QuestionsController do

  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }
    before { get :index }
    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end
    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    sign_in_user
    before { get :new }
    it 'assigns @question to be a new question' do
      expect(assigns(:question)).to be_a_new (Question)
    end
    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #show' do
    before { get :show, id: question }
    it 'it sets variable @question  requested question' do
      expect(assigns(:question)).to eq question
    end
    it 'render show view' do
      expect(response).to render_template :show
    end
    it 'populates an array answers fo question' do
      expect(assigns(:answer)).to be_a_new (Answer)
    end
  end

  describe 'GET #edit' do
    sign_in_user
    before { get :edit, id: question }
    it 'it sets variable @question  requested question' do
      expect(assigns(:question)).to eq question
    end
    it 'render show view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    sign_in_user
    context ' create question with valid attributes' do
      it 'try save new question in database' do
        expect { post :create, question: attributes_for(:question) }
            .to change(Question, :count).by(1)
      end
      it 'redirect to questions#index view' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path
      end
    end
    context ' create question with invalid attributes' do
      it 'try save new question, but not save' do
        expect { post :create, question: attributes_for(:invalid_question) }
            .to_not change(Question, :count)
      end
      it 're render new view' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user
    context 'with valid attributes' do
      it 'it sets variable @question  requested question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(assigns(:question)).to eq question
      end
      it 'change question attributes' do
        patch :update, id: question,
              question: {title: 'new title', text: 'new body'}
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.text).to eq 'new body'
      end
      it 'redirect to show view' do
        patch :update, id: question, question: attributes_for(:question)
        expect(response).to redirect_to question_path
      end
    end
    context 'with invalid attributes' do
      before { patch :update, id: question,
                     question: {title: 'new title', text: nil} }
      it 'do not change question' do
        #expect(question.title).to eq 'MyQuestion'
        expect(question.text).to eq 'MyText'
      end
      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
     before { question.update(user: @user) }
    it 'delete question' do
      expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
    end

     it 'rejects deletion of an foreign question' do
      user = create(:user)
      other_question = create(:other_question, user: user)
      expect { delete :destroy, id: other_question }.not_to change(Question, :count)
    end

    it 'redirect to questions#index view' do
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end
  end
end
