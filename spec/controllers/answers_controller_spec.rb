require 'rails_helper'

describe AnswersController do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:question) { create(:question) }
  let(:answer) { create(:answer, user: user, question: question)}
  let(:another_answer) {create(:answer, user: another_user)}
  
     before(:each) { sign_in(user) }

  describe 'GET #new' do
    before { get :new, question_id: question.id }

    it 'it sets variable @question  requested question' do
      expect(assigns(:question)).to eq question
    end
    it 'assigns @answer to be a new answer' do
      expect(assigns(:answer)).to be_a_new (Answer)
    end
    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context ' create answer with valid attributes' do
      it 'try save new answer in database' do
        expect { post :create, question_id: question.id, answer: attributes_for(:answer) }
            .to change(question.answers, :count).by(1)
      end
      it 'redirect to question#show view' do
        post :create, question_id: question.id, answer: attributes_for(:answer)
        expect(response).to redirect_to question
      end
    end
    context 'create answer with invalid attributes' do
      it 'try save new question, but not save' do
        expect { post :create, question_id: question.id, answer: attributes_for(:invalid_answer) }
            .to_not change(Answer, :count)
      end
      it 're render new view' do
        post :create, question_id: question.id, answer: attributes_for(:invalid_answer)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before { answer.update!(user: user) }

    context 'with valid attributes' do
      it 'it sets variable @answer  requested answer' do
        patch :update, question_id: question.id,
              id: answer, answer: attributes_for(:answer)
        expect(assigns(:answer)).to eq answer
      end
      it 'change answer attributes' do
        patch :update, question_id: question.id,
              id: answer, answer: {text: 'new text'}
        answer.reload
        expect(answer.text).to eq 'new text'
      end
      it 'redirect to  question show view' do
        patch :update, question_id: question.id,
              id: answer, answer: attributes_for(:answer)
        expect(response).to redirect_to question_path(id: question.id)
      end
    end
    context 'with invalid attributes' do
      before { patch :update, question_id: question.id,
                     id: answer, answer: {text: nil} }

      it 'do not change answer' do
        expect(answer.text).to eq 'MyAnswer'
      end
      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { answer }

    it 'it sets variable @answer  requested question' do
      delete :destroy, question_id: question.id,
             id: answer, answer:  attributes_for(:answer)
      expect(assigns(:answer)).to eq answer
    end
    it 'delete own answer' do
      expect { delete :destroy, question_id: question.id,
                      id: answer, user_id: user.id }.to change(Answer, :count).by(-1)
    end
    it 'delete foreign answer' do
      expect { delete :destroy, question_id: question.id,
                      id: another_answer }.to_not change(Answer, :count).by(-1)
    end

    it 'redirect to questions#show view' do
      delete :destroy, question_id: question.id, id: answer
      expect(response).to redirect_to question_path(id: question.id)
    end
  end
end