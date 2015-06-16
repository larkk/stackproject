require 'rails_helper'

feature 'Deleting Answers' do
  given!(:user1) { create(:user) }
  given!(:user) { create(:user) }
  given!(:question1) { create(:question, user: user1) }
  given!(:question) { create(:question, user: user) }
  given!(:answer1) { create(:answer, question: question1, user: user1) }
  given!(:answer) { create(:answer, question: question, user: user)}

  scenario 'Guest cannot delete answers' do
    visit question_path(question1)
    expect(page).to_not have_link 'Delete answer'

  end

  scenario 'a User can delete only his own Answers' do
    sign_in(answer.user)
    visit question_path(id: question.id)
    click_link 'Delete answer'
    expect(page).not_to have_content answer.body
  end

  scenario 'a User cannot delete foreign Answers' do
    sign_in(user)
    visit question_path(question1)
    expect(page).not_to have_content 'Delete answer'
  end
end