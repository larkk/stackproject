require 'rails_helper'

feature 'User delete answer', %q{
  User can delete only own answer
} do

  given!(:user1) { create(:user) }
  given!(:user2) { create(:user) }
  given!(:question1) { create(:question, user: user1) }
  given!(:question2) { create(:question, user: user2) }
  given!(:answer1) { create(:answer, question: question1, user: user1) }
  given!(:answer2) { create(:answer, question: question2, user: user2)}
  scenario 'User can delete his answer' do

    sign_in(user1)
    visit question_path(question1)    
    expect(page).to have_content answer.text
    click_on 'Delete answer'
    expect(page).not_to have_content answer.text

  end

  scenario 'Guest cannot delete answers' do
    visit question_path(question1)
    expect(page).to_not have_link 'Delete answer'

  end

  scenario 'Autenticated user tries to delete other persons answer' do
    sign_in(user1)
    visit question_path(question2)
    expect(page).to_not have_link 'Delete answer'

  end


end