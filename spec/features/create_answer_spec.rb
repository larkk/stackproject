require 'rails_helper'

feature 'The user create answer', %q{
        For helping other users
} do

  given(:question) { create(:question) }
  given(:user) { create(:user) }

  scenario 'Authenticated user creates answer' do

    sign_in(user)

    visit question_path(question)
    fill_in 'Your answer:', with: 'My answer'
    click_on 'Add answer'

    expect(current_path).to eq question_path(question)
    expect(page).to have_content 'You answer added successfully'

  end

  scenario 'Non-authenticate user tries to create answer' do

    visit question_path(question)
    expect(page).to_not have_link 'Your answer'


  end

end