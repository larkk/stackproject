require 'rails_helper'

feature 'User delete answer', %q{
  User can delete only own answer
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:answer) { create(:answer, question: question, user: user) }

  scenario 'User can delete only his answer' do

    sign_in(user)
    visit question_path(question)
    click_on 'Delete answer'
    expect(page).to have_content 'Your answer was deleted successfully'

  end

  scenario 'User tries to delete other persons answer' do
    visit question_path(question)
    expect(page).to_not have_link 'Delete answer'

  end


end