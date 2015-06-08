require 'rails_helper'

feature 'USer sign in', %q{ 
  In order to be able to ask questions 
  As an User
  I want to be able to sign in
} do 
   scenario 'Refisteres user try to sign in' do
   	  User.create!(email: 'alice@test.ru', password: '12345678')

   	visit new_user_session_path
   	fill_in 'Email', with: 'alice@test.ru'
   	fill_in 'Password', with: '12345678'
   	click_on 'Log in'

   	expect(page).to have_content 'Signed in successfully.'
   	expect(current_path).to eq root_path
  end

  scenario 'Non-registered user is trying to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@test.com'
   	fill_in 'Password', with: '12345678'
   	click_on 'Log in'

   	expect(page).to have_content 'Invalid email or password'
   	expect(current_path).to eq new_user_session_path
  end
	
end