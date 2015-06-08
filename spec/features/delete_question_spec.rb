require 'rails_helper'

feature 'User deletes his question' do


  scenario 'User can delete only his question' do

    user = User.create(attributes_for(:user))
    sign_in(user)
    question = user.questions.create(attributes_for(:question))
    visit question_path(question)
    click_on 'Delete question'
    expect(page).to have_content 'Deleted successfully'
    expect(current_path).to eq questions_path

  end

  scenario 'User tries to delete other persons question' do

    question = create(:question)
    visit question_path(question)
    expect(page).to_not have_link 'Delete question'

  end

end