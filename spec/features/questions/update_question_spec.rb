require 'rails_helper'

feature 'The user updates question' do

  given!(:user) { create(:user) }
  given(:other_user) { create(:user) }   
  given!(:question) { create(:question) }
  
  given!(:other_question) { create(:question), user: other_user }

  given!(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:question) { create(:question, user_id: user.id) }
  given!(:answer) { create(:answer, question_id: question.id, user_id: user.id) }

  scenario 'Non-authenticate user tries to update some answer' do

    visit question_path(question)
    expect(page).to_not have_link 'Edit question'

  end

  scenario 'User sees the Edit button' do

    sign_in(user)
    visit question_path(question)
    expect(page).to have_link 'Edit answer'

  end

  scenario 'Authenticated user updates his question with valid attributes', js: true do
  
    sign_in(user)
    visit question_path(question)
    click_on 'Edit question'
    fill_in 'Title:', with: 'My updated question'
    fill_in 'Text:', with: ''
    click_button 'Add answer'

    expect(current_path).to eq question_path(question)
    within '.answers' do
    expect(page).to have_content 'My updated question'
  end
    

  scenario 'Authenticated user updates his question with valid attributes', js: true do
  
    sign_in(user)
    visit question_path(question)
    click_on 'Edit question'
    fill_in 'Title:', with: 'My updated question'
    fill_in 'Text:', with: 'Updated text of my updated question '
    click_button 'Add answer'

    expect(current_path).to eq question_path(question)
    within '.answers' do
    expect(page).to have_content 'My updated question'
    end
  end

  scenario 'Authenticated user tries to update foreign answer', js: true do

    sign_in(user)
    visit question_path(other_question)
    expect(page).to_not have_link 'Edit answer'
  end
end