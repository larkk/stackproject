require 'rails_helper'

feature 'User deletes his question' do

   given(:user) { create(:user) }
   given(:question) { create(:question, user: user) }
   given(:other_question) { create(:other_question) }

  scenario 'User can delete only his question' do

    sign_in(user)
    visit question_path(question)
    click_on 'Delete question'
    expect(page).to have_content 'Deleted successfully'
    expect(current_path).to eq questions_path
    expect(page).to_not have_content question.title

  end

  scenario 'A gest cannot delete questions' do

    visit question_path(question)
    expect(page).to_not have_link 'Delete question'

  end

  scenario 'Autenticated user tries to delete other persons question' do
    log_in(uquestion.user)
    visit question_path(other_question)
    expect(page).to_not have_link 'Delete question'

  end

end