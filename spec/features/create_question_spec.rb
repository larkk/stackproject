require 'rails_helper'

feature 'Create Question', %q{
	In order to get answer from community
	As an autentificated user
	I want to be able to ask questions
}do

 scenario 'Authenticated user creates question'do

    visit new_question_path
    fill_in 'Email', with: 'alice@test.ru'
   	fill_in 'Password', with: '12345678'
   	click_on 'Log in'
    visit questions_path
   	click_on 'Ask question'
   	fill_in 'title', with: 'Test question'
   	fill_in 'text', with: 'text text text'
   	click_on 'Create'

   	expect(page).to have_content 'Your question is created.'
   	#он видит содержимое вопроса, находится на странице вопроса
 end

  scenario 'non-authenticated user tries to create questuin' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end