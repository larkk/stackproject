feature 'User log in' do

  given(:user) { create(:user) }

  scenario 'a Guest cannot log in' do

    fill_in 'Email', with: 'foo@example.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log_in'

    expect(page).to have_content 'Invalid email or password'
    expect(current_path).to eq new_user_session_path
  end

  scenario 'a User can log in' do
    log_in(user)

    expect(current_path).to eq root_path
  end
end