require 'rails_helper'

feature 'The user can log out' do

  given(:user) { create(:user) }

  scenario 'User tries to log out' do

   log_in(user)
    click_on 'Log out'

   expect(page).to have_content 'Signed out successfully.'

  end

end