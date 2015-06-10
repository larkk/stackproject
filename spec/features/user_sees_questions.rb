require 'rails_helper'

feature 'User can see all questions', %q{
  In order to be able to see questions
} do
  scenario 'a Guest can view all Questions' do
    create_list(:polymorfic_question, 10)
    visit root_path

    1.upto(10) do |n|
      expect(page).to have_content "Question_Title-#{n}"
      expect(page).to have_content "Question_Body-#{n}"
    end
  end

end