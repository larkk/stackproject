require 'rails_helper'

feature 'Create Question', %q{
	In order to get answer from community
	As an autentificated user
	I want to be able to ask questions
}do
   
   given!(:user) { create(:user) }

 scenario 'Authenticated user creates question'do

    sign_in(user)
    visit questions_path
   	click_on 'Ask question'
   	fill_in 'Title', with: 'Test question'
   	fill_in 'Text', with: 'text text text'
   	click_on 'Create'

   	expect(page).to have_content 'Your question is created.'
    expect(page).to have_content question.title
    expect(page).to have_content question.body
 end

  scenario 'non-authenticated user tries to create question' do
    visit questions_path
     expect(page).to_not have_content  'Ask question'
  end

end