require 'rails_helper'

feature 'User delete answer', %q{
  User can delete only own answer
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'User can delete his answer' do

    log_in(answer.user)
    visit question_path(question)
    click_on 'Delete answer'
    expect(page).not_to have_content answer.text

  end

  scenario 'Guest cannot delete answers' do
    visit question_path(question)
    expect(page).to_not have_link 'Delete answer'

  end

  scenario 'Autenticated user tries to delete other persons answer' do
    sign_in(user)
    visit question_path(answer.question)
    expect(page).to_not have_link 'Delete answer'

  end


end