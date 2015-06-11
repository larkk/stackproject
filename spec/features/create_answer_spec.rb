require 'rails_helper'

feature 'The user create answer', %q{
        For helping other users
} do

  given(:user) { create(:user) }   
  given(:question) { create(:question) }
  given(:answer) { build(:answer) }
  given(:linked_question) { create(:question, user: user) }

  scenario 'Non-authenticate user tries to create answer' do

    visit question_path(question)
    expect(page).to_not have_link 'Your answer'

  end

  scenario 'Authenticated user creates answer to his quiestion' do

    sign_in(user)
    visit question_path(linked_question)
    fill_in 'Your answer:', with: 'My answerrr'
    click_on 'Add answer'

    expect(current_path).to eq question_path(question)
    expect(page).to have_content 'My answerrr'

  end

  scenario 'a User can post Answers to foreign Questions' do
    sign_in(user)
    visit question_path(question)
    fill_in 'Text', with: answer.text
    click_on 'Add answer'
    expect(current_path).to eq question_path(question)
    expect(page).to have_content answer.text
  end

end