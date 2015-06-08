require 'rails_helper'

feature 'User can see all questions', %q{
  In order to be able to see questions
} do


  scenario 'All users and guests able to see list of questions' do

    questions = create_list(:question, 2)

    visit questions_path

    questions.each do |f|
      expect(page).to have_link f.title
    end

  end

  scenario 'All users and guests can see question and answers to it' do

    question = Question.create(attributes_for(:question))
    question.answers.build(attributes_for(:answer))

    visit question_path(question)

    expect(page).to have_content question.title
    expect(page).to have_content question.body

    question.answers.each do |f|
      expect(page).to have_content f.body
    end
  end

end