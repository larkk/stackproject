
feature 'User sing up' do
  scenario 'a Guest can sing up for an account' do
    user = build(:user)

    visit root_path
    click_on 'Sign_up'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end