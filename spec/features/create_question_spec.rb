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
   	fill_in 'title', with: 'Test question'
   	fill_in 'text', with: 'text text text'
   	click_on 'Create'

   	expect(page).to have_content 'Your question is created.'
 end

  scenario 'non-authenticated user tries to create question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end