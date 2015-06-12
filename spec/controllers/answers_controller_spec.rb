require 'rails_helper'

describe AnswersController do
  let(:user) { create(:user) }
  let(:question) { create(:question, user_id: user.id) }
  let(:answer) { create(:answer, user_id: user.id, question_id: question.id)}
  
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
      
        it 'answer user is the current user' do
        post :create, question_id: question.id,
             answer: attributes_for(:answer)
        expect(assigns(:answer).user).to eq subject.current_user
      end

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
    before { user }
    before { question }
    before { answer }

    context 'with valid attributes' do
      it 'it sets variable @answer  requested answer' do
        patch :update, id: answer, question_id: question.id, answer: attributes_for(:answer)
        expect(assigns(:answer)).to eq answer
      end
      it 'change answer attributes' do
        patch :update, id: answer, question_id: question.id, answer: {text: 'My new text'}
        answer.reload
        expect(answer.text).to eq 'My new text'
      end
      it 'redirect to  question show view' do
        patch :update, question_id: question.id, user_id: user.id,
              id: answer.id, answer: attributes_for(:answer)
        expect(response).to redirect_to question_path(id: question.id)
      end
    end
    context 'with invalid attributes' do
      before { patch :update, question_id: question.id,
                     id: answer, answer: {text: nil} }

      it 'do not change answer' do
        expect(answer.text).to eq 'blahblahblah'
      end
      it 're-render edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { question }
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
      other_user = create(:user)
      other_question = create(:question, user: other_user)
      other_answer = create(:answer, question: other_question, user: other_user)
      expect { delete :destroy, id: other_answer}.to_not change(Answer, :count).by(-1)
    end

    it 'redirect to questions#show view' do
      delete :destroy, question_id: question.id, id: answer
      expect(response).to redirect_to question_path(id: question.id)
    end
  end
end